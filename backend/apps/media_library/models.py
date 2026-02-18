from django.db import models

from common.models import BaseModel


class MediaFile(BaseModel):
    class FileType(models.TextChoices):
        VIDEO = "VIDEO", "Video"
        IMAGE = "IMAGE", "Image"

    title = models.CharField(max_length=255)
    file_type = models.CharField(max_length=5, choices=FileType.choices)
    file = models.FileField(upload_to="media_library/files/")
    thumbnail = models.ImageField(
        upload_to="media_library/thumbnails/",
        blank=True,
    )

    # Metadata
    file_size_bytes = models.PositiveIntegerField(default=0)
    mime_type = models.CharField(max_length=100, blank=True, default="")
    duration_seconds = models.PositiveIntegerField(null=True, blank=True)

    # Processing status (for video transcoding)
    is_processed = models.BooleanField(default=False)

    # External video service (Mux / Cloudflare Stream)
    external_video_id = models.CharField(max_length=255, blank=True, default="")
    external_playback_url = models.URLField(blank=True, default="")

    class Meta:
        ordering = ["-created_at"]
        verbose_name = "Media File"
        verbose_name_plural = "Media Files"

    def __str__(self):
        return f"{self.title} ({self.get_file_type_display()})"
