from django.urls import path

from .views import (
    ProgramDetailView,
    ProgramEnrollView,
    ProgramListView,
    ProgramProgressView,
)

urlpatterns = [
    path("programs/", ProgramListView.as_view(), name="program-list"),
    path("programs/<uuid:pk>/", ProgramDetailView.as_view(), name="program-detail"),
    path("programs/<uuid:pk>/enroll/", ProgramEnrollView.as_view(), name="program-enroll"),
    path("programs/<uuid:pk>/progress/", ProgramProgressView.as_view(), name="program-progress"),
]
