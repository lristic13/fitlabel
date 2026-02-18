from rest_framework.generics import ListAPIView, RetrieveAPIView

from .models import Post
from .serializers import PostDetailSerializer, PostListSerializer


class PostListView(ListAPIView):
    """
    GET /v1/content/posts/
    List published posts for the current tenant.
    """

    serializer_class = PostListSerializer

    def get_queryset(self):
        return Post.objects.filter(
            tenant=self.request.tenant,
            is_published=True,
        ).select_related("cover_image")


class PostDetailView(RetrieveAPIView):
    """
    GET /v1/content/posts/{id}/
    Post detail with full body.
    """

    serializer_class = PostDetailSerializer

    def get_queryset(self):
        return Post.objects.filter(
            tenant=self.request.tenant,
            is_published=True,
        ).select_related("cover_image")
