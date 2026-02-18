from django.utils import timezone
from rest_framework import serializers

from apps.progress.models import ProgramProgress
from apps.workouts.serializers import MediaFileBriefSerializer

from .models import Program, ProgramDay, ProgramWeek


class ProgramListSerializer(serializers.ModelSerializer):
    cover_image = MediaFileBriefSerializer(read_only=True)

    class Meta:
        model = Program
        fields = [
            "id",
            "title",
            "difficulty",
            "duration_weeks",
            "is_free",
            "cover_image",
            "ordering",
        ]


class ProgramDaySerializer(serializers.ModelSerializer):
    workout_id = serializers.UUIDField(source="workout.id", read_only=True, default=None)
    workout_title = serializers.CharField(source="workout.title", read_only=True, default=None)

    class Meta:
        model = ProgramDay
        fields = [
            "id",
            "day_number",
            "title",
            "workout_id",
            "workout_title",
            "is_rest_day",
        ]


class ProgramWeekSerializer(serializers.ModelSerializer):
    days = ProgramDaySerializer(many=True, read_only=True)

    class Meta:
        model = ProgramWeek
        fields = [
            "id",
            "week_number",
            "title",
            "days",
        ]


class ProgramDetailSerializer(serializers.ModelSerializer):
    cover_image = MediaFileBriefSerializer(read_only=True)
    weeks = ProgramWeekSerializer(many=True, read_only=True)

    class Meta:
        model = Program
        fields = [
            "id",
            "title",
            "description",
            "difficulty",
            "duration_weeks",
            "is_free",
            "cover_image",
            "weeks",
        ]


class ProgramProgressSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProgramProgress
        fields = [
            "id",
            "current_week",
            "current_day",
            "started_at",
            "completed_at",
            "is_active",
        ]
