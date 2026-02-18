from rest_framework.permissions import BasePermission


class IsAdminRole(BasePermission):
    """Allow access only to users with the ADMIN role."""

    def has_permission(self, request, view):
        return (
            request.user
            and request.user.is_authenticated
            and request.user.role == "ADMIN"
        )


class IsTenantMember(BasePermission):
    """Allow access only if the user belongs to the request's tenant."""

    def has_permission(self, request, view):
        tenant = getattr(request, "tenant", None)
        if tenant is None:
            return False
        return (
            request.user
            and request.user.is_authenticated
            and request.user.tenant_id == tenant.id
        )
