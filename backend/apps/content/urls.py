from django.urls import path

from .views import PostDetailView, PostListView

urlpatterns = [
    path("posts/", PostListView.as_view(), name="post-list"),
    path("posts/<uuid:pk>/", PostDetailView.as_view(), name="post-detail"),
]
