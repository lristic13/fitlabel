from rest_framework import serializers

from .models import ExerciseLog, ProgramProgress, WorkoutLog


class ExerciseLogSerializer(serializers.ModelSerializer):
    exercise_name = serializers.CharField(source="exercise.name", read_only=True)

    class Meta:
        model = ExerciseLog
        fields = [
            "exercise_name",
            "sets_completed",
            "reps_per_set",
            "weight_per_set",
            "weight_unit",
        ]


class WorkoutHistorySerializer(serializers.ModelSerializer):
    workout_title = serializers.CharField(source="workout.title", read_only=True)
    exercise_logs = ExerciseLogSerializer(many=True, read_only=True)

    class Meta:
        model = WorkoutLog
        fields = [
            "id",
            "workout_title",
            "started_at",
            "completed_at",
            "duration_seconds",
            "notes",
            "exercise_logs",
        ]


class StatsSerializer(serializers.Serializer):
    total_workouts = serializers.IntegerField()
    total_duration_seconds = serializers.IntegerField()
    current_streak = serializers.IntegerField()
    longest_streak = serializers.IntegerField()
    active_programs = serializers.IntegerField()
