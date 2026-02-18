from django.contrib import admin
from unfold.admin import ModelAdmin

from .models import MediaFile


@admin.register(MediaFile)
class MediaFileAdmin(ModelAdmin):
    list_display = ["title", "file_type", "file_size_display", "is_processed", "created_at"]
    list_filter = ["file_type", "is_processed"]
    search_fields = ["title"]
    readonly_fields = ["id", "file_size_bytes", "created_at", "updated_at"]
    fieldsets = [
        (None, {"fields": ("id", "tenant", "title", "file_type")}),
        ("File", {"fields": ("file", "thumbnail", "file_size_bytes", "mime_type")}),
        (
            "Video Details",
            {
                "fields": (
                    "duration_seconds",
                    "is_processed",
                    "external_video_id",
                    "external_playback_url",
                ),
            },
        ),
        ("Timestamps", {"fields": ("created_at", "updated_at")}),
    ]

    def file_size_display(self, obj):
        if obj.file_size_bytes < 1024:
            return f"{obj.file_size_bytes} B"
        elif obj.file_size_bytes < 1024 * 1024:
            return f"{obj.file_size_bytes / 1024:.1f} KB"
        return f"{obj.file_size_bytes / (1024 * 1024):.1f} MB"

    file_size_display.short_description = "File Size"

    def get_queryset(self, request):
        qs = super().get_queryset(request)
        if request.user.is_superuser:
            return qs
        return qs.filter(tenant=request.user.tenant)

    def save_model(self, request, obj, form, change):
        if not change and not obj.tenant_id and not request.user.is_superuser:
            obj.tenant = request.user.tenant
        super().save_model(request, obj, form, change)
