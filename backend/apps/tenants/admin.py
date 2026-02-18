from django.contrib import admin
from unfold.admin import ModelAdmin

from .models import Tenant


@admin.register(Tenant)
class TenantAdmin(ModelAdmin):
    list_display = ["name", "slug", "is_active", "created_at"]
    list_filter = ["is_active"]
    search_fields = ["name", "slug"]
    prepopulated_fields = {"slug": ("name",)}
    readonly_fields = ["id", "created_at", "updated_at"]
    fieldsets = [
        (None, {"fields": ("id", "name", "slug", "owner", "is_active")}),
        (
            "Branding",
            {
                "fields": (
                    "app_name",
                    "primary_color",
                    "secondary_color",
                    "logo",
                    "splash_image",
                )
            },
        ),
        ("Store IDs", {"fields": ("app_store_id", "play_store_id")}),
        ("Timestamps", {"fields": ("created_at", "updated_at")}),
    ]

    def get_queryset(self, request):
        qs = super().get_queryset(request)
        if request.user.is_superuser:
            return qs
        return qs.filter(owner=request.user)
