from django.contrib import admin
from unfold.admin import ModelAdmin, TabularInline

from .models import ExerciseLog, ProgramProgress, WorkoutLog


class ExerciseLogInline(TabularInline):
    model = ExerciseLog
    extra = 0
    fields = ["exercise", "sets_completed", "reps_per_set", "weight_per_set", "weight_unit"]


@admin.register(WorkoutLog)
class WorkoutLogAdmin(ModelAdmin):
    list_display = ["user", "workout", "started_at", "completed_at", "duration_display"]
    list_filter = ["started_at"]
    search_fields = ["user__email", "workout__title"]
    readonly_fields = ["id", "created_at", "updated_at"]
    inlines = [ExerciseLogInline]
    fieldsets = [
        (None, {"fields": ("id", "tenant", "user", "workout", "program_day")}),
        ("Timing", {"fields": ("started_at", "completed_at", "duration_seconds")}),
        ("Notes", {"fields": ("notes",)}),
        ("Timestamps", {"fields": ("created_at", "updated_at")}),
    ]

    def duration_display(self, obj):
        if obj.duration_seconds is None:
            return "—"
        mins, secs = divmod(obj.duration_seconds, 60)
        return f"{mins}m {secs}s"

    duration_display.short_description = "Duration"

    def get_queryset(self, request):
        qs = super().get_queryset(request)
        if request.user.is_superuser:
            return qs
        return qs.filter(tenant=request.user.tenant)


@admin.register(ProgramProgress)
class ProgramProgressAdmin(ModelAdmin):
    list_display = ["user", "program", "current_week", "current_day", "is_active", "started_at"]
    list_filter = ["is_active"]
    search_fields = ["user__email", "program__title"]
    readonly_fields = ["id", "started_at", "created_at", "updated_at"]
    fieldsets = [
        (None, {"fields": ("id", "tenant", "user", "program")}),
        ("Progress", {"fields": ("current_week", "current_day", "is_active")}),
        ("Dates", {"fields": ("started_at", "completed_at", "created_at", "updated_at")}),
    ]

    def get_queryset(self, request):
        qs = super().get_queryset(request)
        if request.user.is_superuser:
            return qs
        return qs.filter(tenant=request.user.tenant)
