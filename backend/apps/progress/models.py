from django.conf import settings
from django.db import models

from common.models import BaseModel


class WorkoutLog(BaseModel):
    """Records a single workout session by a user."""

    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name="workout_logs",
    )
    workout = models.ForeignKey(
        "workouts.Workout",
        on_delete=models.CASCADE,
        related_name="logs",
    )
    program_day = models.ForeignKey(
        "programs.ProgramDay",
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="logs",
    )
    started_at = models.DateTimeField()
    completed_at = models.DateTimeField(null=True, blank=True)
    duration_seconds = models.PositiveIntegerField(null=True, blank=True)
    notes = models.TextField(blank=True, default="")

    class Meta:
        ordering = ["-started_at"]

    def __str__(self):
        return f"{self.user.email} — {self.workout.title} ({self.started_at:%Y-%m-%d})"


class ExerciseLog(models.Model):
    """Records per-exercise details within a workout session."""

    workout_log = models.ForeignKey(
        WorkoutLog,
        on_delete=models.CASCADE,
        related_name="exercise_logs",
    )
    exercise = models.ForeignKey(
        "workouts.Exercise",
        on_delete=models.CASCADE,
        related_name="logs",
    )
    sets_completed = models.PositiveIntegerField(default=0)
    reps_per_set = models.JSONField(
        default=list,
        blank=True,
        help_text="e.g. [12, 10, 8]",
    )
    weight_per_set = models.JSONField(
        default=list,
        blank=True,
        help_text="e.g. [60, 65, 70]",
    )

    class WeightUnit(models.TextChoices):
        KG = "KG", "Kilograms"
        LBS = "LBS", "Pounds"

    weight_unit = models.CharField(
        max_length=3,
        choices=WeightUnit.choices,
        default=WeightUnit.KG,
    )

    class Meta:
        ordering = ["id"]

    def __str__(self):
        return f"{self.exercise.name} — {self.sets_completed} sets"


class ProgramProgress(BaseModel):
    """Tracks a user's progress through a program."""

    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name="program_progress",
    )
    program = models.ForeignKey(
        "programs.Program",
        on_delete=models.CASCADE,
        related_name="progress",
    )
    current_week = models.PositiveIntegerField(default=1)
    current_day = models.PositiveIntegerField(default=1)
    started_at = models.DateTimeField(auto_now_add=True)
    completed_at = models.DateTimeField(null=True, blank=True)
    is_active = models.BooleanField(default=True)

    class Meta:
        ordering = ["-started_at"]
        verbose_name_plural = "Program progress"

    def __str__(self):
        return f"{self.user.email} — {self.program.title} (W{self.current_week}D{self.current_day})"
