from django.contrib import admin
from unfold.admin import ModelAdmin, StackedInline, TabularInline

from .models import Program, ProgramDay, ProgramWeek


class ProgramDayInline(TabularInline):
    model = ProgramDay
    extra = 1
    fields = ["day_number", "title", "workout", "is_rest_day"]
    ordering = ["day_number"]


class ProgramWeekInline(StackedInline):
    model = ProgramWeek
    extra = 1
    fields = ["week_number", "title"]
    ordering = ["week_number"]
    show_change_link = True


@admin.register(Program)
class ProgramAdmin(ModelAdmin):
    list_display = ["title", "difficulty", "duration_weeks", "is_published", "is_free", "ordering"]
    list_filter = ["difficulty", "is_published", "is_free"]
    list_editable = ["ordering", "is_published"]
    search_fields = ["title"]
    readonly_fields = ["id", "created_at", "updated_at"]
    inlines = [ProgramWeekInline]
    fieldsets = [
        (None, {"fields": ("id", "tenant", "title", "description", "cover_image")}),
        ("Settings", {"fields": ("difficulty", "duration_weeks", "is_published", "is_free", "ordering")}),
        ("Timestamps", {"fields": ("created_at", "updated_at")}),
    ]

    def get_queryset(self, request):
        qs = super().get_queryset(request)
        if request.user.is_superuser:
            return qs
        return qs.filter(tenant=request.user.tenant)

    def save_model(self, request, obj, form, change):
        if not change and not obj.tenant_id and not request.user.is_superuser:
            obj.tenant = request.user.tenant
        super().save_model(request, obj, form, change)


@admin.register(ProgramWeek)
class ProgramWeekAdmin(ModelAdmin):
    list_display = ["__str__", "week_number", "day_count"]
    search_fields = ["program__title", "title"]
    readonly_fields = ["id"]
    inlines = [ProgramDayInline]

    def day_count(self, obj):
        return obj.days.count()

    day_count.short_description = "Days"

    def get_queryset(self, request):
        qs = super().get_queryset(request)
        if request.user.is_superuser:
            return qs
        return qs.filter(program__tenant=request.user.tenant)
