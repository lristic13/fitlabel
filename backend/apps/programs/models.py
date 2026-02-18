from django.db import models

from common.models import BaseModel


class Program(BaseModel):
    class Difficulty(models.TextChoices):
        BEGINNER = "BEGINNER", "Beginner"
        INTERMEDIATE = "INTERMEDIATE", "Intermediate"
        ADVANCED = "ADVANCED", "Advanced"

    title = models.CharField(max_length=255)
    description = models.TextField(blank=True, default="")
    cover_image = models.ForeignKey(
        "media_library.MediaFile",
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="program_covers",
    )
    difficulty = models.CharField(
        max_length=12,
        choices=Difficulty.choices,
        default=Difficulty.BEGINNER,
    )
    duration_weeks = models.PositiveIntegerField(default=1)
    is_published = models.BooleanField(default=False)
    is_free = models.BooleanField(default=True)
    ordering = models.PositiveIntegerField(default=0)

    class Meta:
        ordering = ["ordering", "-created_at"]

    def __str__(self):
        return self.title


class ProgramWeek(models.Model):
    program = models.ForeignKey(
        Program,
        on_delete=models.CASCADE,
        related_name="weeks",
    )
    week_number = models.PositiveIntegerField()
    title = models.CharField(max_length=255, blank=True, default="")

    class Meta:
        ordering = ["week_number"]
        unique_together = [("program", "week_number")]

    def __str__(self):
        label = self.title or f"Week {self.week_number}"
        return f"{self.program.title} — {label}"


class ProgramDay(models.Model):
    week = models.ForeignKey(
        ProgramWeek,
        on_delete=models.CASCADE,
        related_name="days",
    )
    day_number = models.PositiveIntegerField()
    title = models.CharField(max_length=255, blank=True, default="")
    workout = models.ForeignKey(
        "workouts.Workout",
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="program_days",
    )
    is_rest_day = models.BooleanField(default=False)

    class Meta:
        ordering = ["day_number"]
        unique_together = [("week", "day_number")]

    def __str__(self):
        label = self.title or f"Day {self.day_number}"
        if self.is_rest_day:
            label += " (Rest)"
        return f"{self.week} — {label}"
