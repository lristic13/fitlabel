from django.db.models import Count
from django.shortcuts import get_object_or_404
from django.utils import timezone
from drf_spectacular.utils import extend_schema
from rest_framework import status
from rest_framework.generics import ListAPIView, RetrieveAPIView
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from rest_framework.views import APIView

from apps.progress.models import ExerciseLog, WorkoutLog

from .models import Exercise, Workout
from .serializers import (
    ExerciseDetailSerializer,
    ExerciseListSerializer,
    WorkoutCompleteSerializer,
    WorkoutDetailSerializer,
    WorkoutListSerializer,
    WorkoutLogResponseSerializer,
    WorkoutStartSerializer,
)


class MuscleGroupListView(APIView):
    """
    GET /v1/exercises/muscle-groups/
    Returns the fixed list of muscle-group categories.
    """

    permission_classes = [AllowAny]

    MUSCLE_GROUPS = [
        {"value": "chest", "label": "Chest"},
        {"value": "back", "label": "Back"},
        {"value": "shoulders", "label": "Shoulders"},
        {"value": "biceps", "label": "Biceps"},
        {"value": "triceps", "label": "Triceps"},
        {"value": "legs", "label": "Legs"},
        {"value": "glutes", "label": "Glutes"},
        {"value": "core", "label": "Core"},
        {"value": "full_body", "label": "Full Body"},
        {"value": "cardio", "label": "Cardio"},
    ]

    def get(self, request):
        return Response(self.MUSCLE_GROUPS)


class WorkoutListView(ListAPIView):
    """
    GET /v1/workouts/
    List all workouts for the current tenant.
    Supports optional ?search= and ?muscle_groups= query params.
    """

    serializer_class = WorkoutListSerializer

    def get_queryset(self):
        qs = (
            Workout.objects.filter(tenant=self.request.tenant)
            .select_related("cover_image")
            .prefetch_related("exercise_entries__exercise")
            .annotate(exercise_count=Count("exercise_entries"))
            .order_by("-created_at")
        )

        search = self.request.query_params.get("search")
        if search:
            qs = qs.filter(title__icontains=search)

        muscle_groups = self.request.query_params.get("muscle_groups")
        if muscle_groups:
            groups = [g.strip() for g in muscle_groups.split(",") if g.strip()]
            if groups:
                from django.db.models import Q

                mg_filter = Q()
                for group in groups:
                    mg_filter |= Q(
                        exercise_entries__exercise__muscle_groups__contains=[group]
                    )
                qs = qs.filter(mg_filter).distinct()

        return qs


class ExerciseListView(ListAPIView):
    """
    GET /v1/exercises/
    List all exercises for the current tenant.
    Supports ?search= (name) and ?equipment= filtering.
    """

    serializer_class = ExerciseListSerializer

    def get_queryset(self):
        qs = Exercise.objects.filter(
            tenant=self.request.tenant,
        ).select_related("demo_image")

        search = self.request.query_params.get("search")
        if search:
            qs = qs.filter(name__icontains=search)

        equipment = self.request.query_params.get("equipment")
        if equipment:
            qs = qs.filter(equipment__iexact=equipment)

        return qs


class ExerciseDetailView(RetrieveAPIView):
    """
    GET /v1/exercises/{id}/
    Exercise detail with video and image URLs.
    """

    serializer_class = ExerciseDetailSerializer

    def get_queryset(self):
        return Exercise.objects.filter(
            tenant=self.request.tenant,
        ).select_related("demo_video", "demo_image")


class WorkoutDetailView(RetrieveAPIView):
    """
    GET /v1/workouts/{id}/
    Workout detail with all exercises and their sets/reps config.
    """

    serializer_class = WorkoutDetailSerializer

    def get_queryset(self):
        return (
            Workout.objects.filter(tenant=self.request.tenant)
            .select_related("cover_image")
            .prefetch_related(
                "exercise_entries__exercise__demo_image",
            )
        )


class WorkoutStartView(APIView):
    """
    POST /v1/workouts/{id}/start/
    Start a workout session. Creates a WorkoutLog.
    """

    @extend_schema(
        request=WorkoutStartSerializer,
        responses={201: WorkoutLogResponseSerializer},
    )
    def post(self, request, pk):
        workout = get_object_or_404(
            Workout, pk=pk, tenant=request.tenant,
        )

        serializer = WorkoutStartSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        log = WorkoutLog.objects.create(
            tenant=request.tenant,
            user=request.user,
            workout=workout,
            program_day_id=serializer.validated_data.get("program_day_id"),
            started_at=timezone.now(),
        )

        return Response(
            WorkoutLogResponseSerializer(log).data,
            status=status.HTTP_201_CREATED,
        )


class WorkoutCompleteView(APIView):
    """
    POST /v1/workouts/{id}/complete/
    Complete a workout session. Updates the WorkoutLog and saves exercise logs.
    """

    @extend_schema(
        request=WorkoutCompleteSerializer,
        responses={200: WorkoutLogResponseSerializer},
    )
    def post(self, request, pk):
        workout = get_object_or_404(
            Workout, pk=pk, tenant=request.tenant,
        )

        serializer = WorkoutCompleteSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        log = get_object_or_404(
            WorkoutLog,
            pk=serializer.validated_data["workout_log_id"],
            workout=workout,
            user=request.user,
            completed_at__isnull=True,
        )

        now = timezone.now()
        log.completed_at = now
        log.duration_seconds = int((now - log.started_at).total_seconds())
        log.notes = serializer.validated_data.get("notes", "")
        log.save()

        # Bulk-create exercise logs
        exercise_logs = []
        for entry in serializer.validated_data.get("exercise_logs", []):
            exercise_logs.append(
                ExerciseLog(
                    workout_log=log,
                    exercise_id=entry["exercise_id"],
                    sets_completed=entry["sets_completed"],
                    reps_per_set=entry.get("reps_per_set", []),
                    weight_per_set=entry.get("weight_per_set", []),
                    weight_unit=entry.get("weight_unit", "KG"),
                )
            )
        if exercise_logs:
            ExerciseLog.objects.bulk_create(exercise_logs)

        return Response(WorkoutLogResponseSerializer(log).data)
