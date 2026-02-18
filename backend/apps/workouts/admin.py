from django.contrib import admin
from unfold.admin import ModelAdmin, TabularInline

from .models import Exercise, ExerciseInWorkout, Workout


class ExerciseInWorkoutInline(TabularInline):
    model = ExerciseInWorkout
    extra = 1
    fields = ["ordering", "exercise", "sets", "reps", "rest_seconds", "superset_group", "notes"]
    ordering = ["ordering"]


@admin.register(Exercise)
class ExerciseAdmin(ModelAdmin):
    list_display = ["name", "equipment", "muscle_groups_display", "created_at"]
    list_filter = ["equipment"]
    search_fields = ["name"]
    readonly_fields = ["id", "created_at", "updated_at"]
    fieldsets = [
        (None, {"fields": ("id", "tenant", "name", "description")}),
        ("Media", {"fields": ("demo_video", "demo_image")}),
        ("Details", {"fields": ("muscle_groups", "equipment", "instructions")}),
        ("Timestamps", {"fields": ("created_at", "updated_at")}),
    ]

    def muscle_groups_display(self, obj):
        return ", ".join(obj.muscle_groups) if obj.muscle_groups else "—"

    muscle_groups_display.short_description = "Muscle Groups"

    def get_queryset(self, request):
        qs = super().get_queryset(request)
        if request.user.is_superuser:
            return qs
        return qs.filter(tenant=request.user.tenant)

    def save_model(self, request, obj, form, change):
        if not change and not obj.tenant_id and not request.user.is_superuser:
            obj.tenant = request.user.tenant
        super().save_model(request, obj, form, change)


@admin.register(Workout)
class WorkoutAdmin(ModelAdmin):
    list_display = ["title", "estimated_duration_minutes", "exercise_count", "created_at"]
    search_fields = ["title"]
    readonly_fields = ["id", "created_at", "updated_at"]
    inlines = [ExerciseInWorkoutInline]
    fieldsets = [
        (None, {"fields": ("id", "tenant", "title", "description")}),
        ("Details", {"fields": ("estimated_duration_minutes", "cover_image")}),
        ("Timestamps", {"fields": ("created_at", "updated_at")}),
    ]

    def exercise_count(self, obj):
        return obj.exercise_entries.count()

    exercise_count.short_description = "Exercises"

    def get_queryset(self, request):
        qs = super().get_queryset(request)
        if request.user.is_superuser:
            return qs
        return qs.filter(tenant=request.user.tenant)

    def save_model(self, request, obj, form, change):
        if not change and not obj.tenant_id and not request.user.is_superuser:
            obj.tenant = request.user.tenant
        super().save_model(request, obj, form, change)
