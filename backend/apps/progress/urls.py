from django.urls import path

from .views import StatsView, WorkoutHistoryView

urlpatterns = [
    path("history/", WorkoutHistoryView.as_view(), name="progress-history"),
    path("stats/", StatsView.as_view(), name="progress-stats"),
]
