from django.contrib.auth import get_user_model
from rest_framework import serializers
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer

from apps.tenants.models import Tenant

User = get_user_model()


class CustomTokenObtainPairSerializer(TokenObtainPairSerializer):
    """Embed tenant_id, tenant_slug, and role in the JWT."""

    @classmethod
    def get_token(cls, user):
        token = super().get_token(user)
        token["role"] = user.role
        if user.tenant_id:
            token["tenant_id"] = str(user.tenant_id)
            token["tenant_slug"] = user.tenant.slug
        return token


class RegisterSerializer(serializers.Serializer):
    email = serializers.EmailField()
    password = serializers.CharField(write_only=True, min_length=8)
    tenant_slug = serializers.SlugField()

    def validate_email(self, value):
        if User.objects.filter(email__iexact=value).exists():
            raise serializers.ValidationError("A user with this email already exists.")
        return value.lower()

    def validate_tenant_slug(self, value):
        if not Tenant.objects.filter(slug=value, is_active=True).exists():
            raise serializers.ValidationError("Tenant not found.")
        return value

    def create(self, validated_data):
        tenant = Tenant.objects.get(slug=validated_data["tenant_slug"])
        user = User.objects.create_user(
            email=validated_data["email"],
            password=validated_data["password"],
            tenant=tenant,
        )
        return user


class UserProfileSerializer(serializers.ModelSerializer):
    tenant_slug = serializers.CharField(source="tenant.slug", read_only=True)

    class Meta:
        model = User
        fields = [
            "id",
            "email",
            "first_name",
            "last_name",
            "role",
            "avatar",
            "date_of_birth",
            "is_premium",
            "tenant_slug",
            "date_joined",
        ]
        read_only_fields = ["id", "email", "role", "is_premium", "tenant_slug", "date_joined"]
