from django.db import models

from common.models import BaseModel


class Exercise(BaseModel):
    name = models.CharField(max_length=255)
    description = models.TextField(blank=True, default="")
    demo_video = models.ForeignKey(
        "media_library.MediaFile",
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="exercise_demo_videos",
    )
    demo_image = models.ForeignKey(
        "media_library.MediaFile",
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="exercise_demo_images",
    )
    muscle_groups = models.JSONField(
        default=list,
        blank=True,
        help_text='List of muscle groups, e.g. ["quads", "glutes"]',
    )
    equipment = models.CharField(max_length=100, blank=True, default="")
    instructions = models.TextField(blank=True, default="")

    class Meta:
        ordering = ["name"]

    def __str__(self):
        return self.name


class Workout(BaseModel):
    title = models.CharField(max_length=255)
    description = models.TextField(blank=True, default="")
    estimated_duration_minutes = models.PositiveIntegerField(default=0)
    cover_image = models.ForeignKey(
        "media_library.MediaFile",
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="workout_covers",
    )
    exercises = models.ManyToManyField(
        Exercise,
        through="ExerciseInWorkout",
        related_name="workouts",
    )

    class Meta:
        ordering = ["-created_at"]

    def __str__(self):
        return self.title


class ExerciseInWorkout(models.Model):
    """Through table — defines ordering, sets/reps config for an exercise in a workout."""

    workout = models.ForeignKey(
        Workout,
        on_delete=models.CASCADE,
        related_name="exercise_entries",
    )
    exercise = models.ForeignKey(
        Exercise,
        on_delete=models.CASCADE,
        related_name="workout_entries",
    )
    ordering = models.PositiveIntegerField(default=0)
    sets = models.PositiveIntegerField(default=3)
    reps = models.CharField(
        max_length=50,
        default="12",
        help_text='e.g. "12", "8-12", "AMRAP", "30 sec"',
    )
    rest_seconds = models.PositiveIntegerField(default=60)
    notes = models.CharField(max_length=255, blank=True, default="")
    superset_group = models.PositiveIntegerField(
        null=True,
        blank=True,
        help_text="Exercises with the same number are supersetted together.",
    )

    class Meta:
        ordering = ["ordering"]
        unique_together = [("workout", "ordering")]

    def __str__(self):
        return f"{self.workout.title} — {self.exercise.name} (#{self.ordering})"
