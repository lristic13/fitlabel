from rest_framework import serializers

from .models import Tenant


class TenantBrandingSerializer(serializers.ModelSerializer):
    class Meta:
        model = Tenant
        fields = [
            "id",
            "name",
            "slug",
            "app_name",
            "primary_color",
            "secondary_color",
            "logo",
            "splash_image",
        ]
