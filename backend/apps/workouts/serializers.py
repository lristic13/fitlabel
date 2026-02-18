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

    class Meta:
        model = Workout
        fields = [
            "id",
            "title",
            "description",
            "estimated_duration_minutes",
            "cover_image",
            "exercise_entries",
        ]


class WorkoutStartSerializer(serializers.Serializer):
    """Request body for starting a workout session."""

    program_day_id = serializers.UUIDField(required=False, allow_null=True)


class WorkoutLogResponseSerializer(serializers.ModelSerializer):
    """Response for start/complete workout."""

    class Meta:
        model = WorkoutLog
        fields = [
            "id",
            "workout",
            "started_at",
            "completed_at",
            "duration_seconds",
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
    notes = serializers.CharField(required=False, default="")
    exercise_logs = ExerciseLogInputSerializer(many=True, required=False, default=list)
