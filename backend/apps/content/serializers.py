from rest_framework import serializers

from apps.workouts.serializers import MediaFileBriefSerializer

from .models import Post


class PostListSerializer(serializers.ModelSerializer):
    cover_image = MediaFileBriefSerializer(read_only=True)

    class Meta:
        model = Post
        fields = [
            "id",
            "title",
            "cover_image",
            "is_free",
            "published_at",
        ]


class PostDetailSerializer(serializers.ModelSerializer):
    cover_image = MediaFileBriefSerializer(read_only=True)

    class Meta:
        model = Post
        fields = [
            "id",
            "title",
            "body",
            "cover_image",
            "is_free",
            "published_at",
        ]
