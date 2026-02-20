from django.utils import timezone
from rest_framework import serializers

from apps.media_library.models import MediaFile
from apps.progress.models import ExerciseLog, WorkoutLog

from .models import Exercise, ExerciseInWorkout, Workout


class MediaFileBriefSerializer(serializers.ModelSerializer):
    """Lightweight media representation for nested use."""

    class Meta:
        model = MediaFile
        fields = ["id", "title", "file_type", "file", "thumbnail", "external_playback_url"]


class WorkoutListSerializer(serializers.ModelSerializer):
    """Lean representation for workout browse lists."""

    cover_image = MediaFileBriefSerializer(read_only=True)
    exercise_count = serializers.IntegerField(read_only=True)

    class Meta:
        model = Workout
        fields = [
            "id",
            "title",
            "estimated_duration_minutes",
            "cover_image",
            "exercise_count",
        ]


class ExerciseListSerializer(serializers.ModelSerializer):
    demo_image = MediaFileBriefSerializer(read_only=True)

    class Meta:
        model = Exercise
        fields = [
            "id",
            "name",
            "muscle_groups",
            "equipment",
            "demo_image",
        ]


class ExerciseDetailSerializer(serializers.ModelSerializer):
    demo_video = MediaFileBriefSerializer(read_only=True)
    demo_image = MediaFileBriefSerializer(read_only=True)

    class Meta:
        model = Exercise
        fields = [
            "id",
            "name",
            "description",
            "demo_video",
            "demo_image",
            "muscle_groups",
            "equipment",
            "instructions",
        ]


# ---------------------------------------------------------------------------
# Workout serializers
# ---------------------------------------------------------------------------


class ExerciseInWorkoutSerializer(serializers.ModelSerializer):
    """Nested representation of an exercise within a workout."""

    exercise = ExerciseListSerializer(read_only=True)

    class Meta:
        model = ExerciseInWorkout
        fields = [
            "exercise",
            "ordering",
            "sets",
            "reps",
            "rest_seconds",
            "notes",
            "superset_group",
        ]


class WorkoutDetailSerializer(serializers.ModelSerializer):
    cover_image = MediaFileBriefSerializer(read_only=True)
    exercise_entries = ExerciseInWorkoutSerializer(many=True, read_only=True)
    latest_log = serializers.SerializerMethodField()

    class Meta:
        model = Workout
        fields = [
            "id",
            "title",
            "description",
            "estimated_duration_minutes",
            "cover_image",
            "exercise_entries",
            "latest_log",
        ]

    def get_latest_log(self, obj):
        request = self.context.get("request")
        if not request or not request.user.is_authenticated:
            return None
        filters = {"workout": obj, "user": request.user}
        # When accessed from a program day context, scope to that day
        program_day_id = request.query_params.get("program_day_id")
        if program_day_id:
            filters["program_day_id"] = program_day_id
        log = (
            WorkoutLog.objects.filter(**filters)
            .order_by("-started_at")
            .first()
        )
        if log is None:
            return None
        return WorkoutLogResponseSerializer(log).data


class WorkoutStartSerializer(serializers.Serializer):
    """Request body for starting a workout session."""

    program_day_id = serializers.IntegerField(required=False, allow_null=True)


class ExerciseLogOutputSerializer(serializers.ModelSerializer):
    """Read-only representation of a logged exercise."""

    class Meta:
        model = ExerciseLog
        fields = [
            "exercise",
            "sets_completed",
            "reps_per_set",
            "weight_per_set",
            "weight_unit",
        ]


class WorkoutLogResponseSerializer(serializers.ModelSerializer):
    """Response for start/complete workout."""

    exercise_logs = ExerciseLogOutputSerializer(many=True, read_only=True)

    class Meta:
        model = WorkoutLog
        fields = [
            "id",
            "workout",
            "started_at",
            "completed_at",
            "duration_seconds",
            "exercise_logs",
        ]


class ExerciseLogInputSerializer(serializers.Serializer):
    """One exercise entry submitted when completing a workout."""

    exercise_id = serializers.UUIDField()
    sets_completed = serializers.IntegerField(min_value=0)
    reps_per_set = serializers.ListField(
        child=serializers.IntegerField(min_value=0),
        required=False,
        default=list,
    )
    weight_per_set = serializers.ListField(
        child=serializers.FloatField(min_value=0),
        required=False,
        default=list,
    )
    weight_unit = serializers.ChoiceField(
        choices=ExerciseLog.WeightUnit.choices,
        default=ExerciseLog.WeightUnit.KG,
    )


class WorkoutCompleteSerializer(serializers.Serializer):
    """Request body for completing a workout session."""

    workout_log_id = serializers.UUIDField()
    notes = serializers.CharField(required=False, default="", allow_blank=True)
    exercise_logs = ExerciseLogInputSerializer(many=True, required=False, default=list)
