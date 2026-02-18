from django.db import models

from common.models import BaseModel


class Post(BaseModel):
    title = models.CharField(max_length=255)
    body = models.TextField(help_text="Supports markdown.")
    cover_image = models.ForeignKey(
        "media_library.MediaFile",
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="post_covers",
    )
    is_published = models.BooleanField(default=False)
    published_at = models.DateTimeField(null=True, blank=True)
    is_free = models.BooleanField(default=True)

    class Meta:
        ordering = ["-published_at", "-created_at"]

    def __str__(self):
        return self.title
