from django.http import JsonResponse

from .models import Tenant


class TenantMiddleware:
    """
    Resolve tenant from (in priority order):
    1. X-Tenant-Slug header
    2. Subdomain (slug.api.fitlabel.com)
    3. JWT token (user's tenant)

    Attaches tenant to request.tenant. Skips resolution for admin and
    paths that don't need a tenant (e.g. auth endpoints where tenant
    comes from the request body).
    """

    EXEMPT_PREFIXES = ("/admin/", "/v1/auth/", "/__debug__/", "/api/")

    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        request.tenant = None

        if any(request.path.startswith(p) for p in self.EXEMPT_PREFIXES):
            return self.get_response(request)

        tenant = self._resolve(request)
        if tenant is None:
            return JsonResponse(
                {"detail": "Tenant could not be resolved."},
                status=400,
            )

        request.tenant = tenant
        return self.get_response(request)

    def _resolve(self, request):
        # Strategy 1: explicit header
        slug = request.headers.get("X-Tenant-Slug")
        if slug:
            return Tenant.objects.filter(slug=slug, is_active=True).first()

        # Strategy 2: subdomain
        host = request.get_host().split(":")[0]
        parts = host.split(".")
        if len(parts) > 2:
            subdomain = parts[0]
            return Tenant.objects.filter(slug=subdomain, is_active=True).first()

        # Strategy 3: authenticated user's tenant
        user = getattr(request, "user", None)
        if user and getattr(user, "is_authenticated", False) and user.tenant_id:
            return Tenant.objects.filter(id=user.tenant_id, is_active=True).first()

        return None
