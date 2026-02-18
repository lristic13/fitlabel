from drf_spectacular.utils import OpenApiParameter, extend_schema
from rest_framework import status
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from rest_framework.views import APIView

from .models import Tenant
from .serializers import TenantBrandingSerializer


class TenantConfigView(APIView):
    """
    GET /v1/config/
    Returns tenant branding configuration for mobile app startup.
    Resolves tenant from X-Tenant-Slug header or subdomain.
    """

    permission_classes = [AllowAny]

    @extend_schema(
        parameters=[
            OpenApiParameter(
                name="X-Tenant-Slug",
                location=OpenApiParameter.HEADER,
                required=True,
                type=str,
                description="The tenant's unique slug (e.g. 'test-gym')",
            ),
        ],
        responses={200: TenantBrandingSerializer},
    )
    def get(self, request):
        # Try header first, then subdomain
        slug = request.headers.get("X-Tenant-Slug")

        if not slug:
            host = request.get_host().split(":")[0]
            parts = host.split(".")
            if len(parts) > 2:
                slug = parts[0]

        if not slug:
            return Response(
                {"detail": "X-Tenant-Slug header is required."},
                status=status.HTTP_400_BAD_REQUEST,
            )

        tenant = Tenant.objects.filter(slug=slug, is_active=True).first()
        if not tenant:
            return Response(
                {"detail": "Tenant not found."},
                status=status.HTTP_404_NOT_FOUND,
            )

        serializer = TenantBrandingSerializer(tenant, context={"request": request})
        return Response(serializer.data)
