from django.contrib import admin
from unfold.admin import ModelAdmin

from .models import Post


@admin.register(Post)
class PostAdmin(ModelAdmin):
    list_display = ["title", "is_published", "is_free", "published_at", "created_at"]
    list_filter = ["is_published", "is_free"]
    list_editable = ["is_published"]
    search_fields = ["title", "body"]
    readonly_fields = ["id", "created_at", "updated_at"]
    fieldsets = [
        (None, {"fields": ("id", "tenant", "title", "body", "cover_image")}),
        ("Publishing", {"fields": ("is_published", "published_at", "is_free")}),
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
