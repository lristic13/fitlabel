from django.urls import path

from .views import (
    ExerciseDetailView,
    ExerciseListView,
    WorkoutCompleteView,
    WorkoutDetailView,
    WorkoutListView,
    WorkoutStartView,
)

urlpatterns = [
    path("workouts/", WorkoutListView.as_view(), name="workout-list"),
    path("exercises/", ExerciseListView.as_view(), name="exercise-list"),
    path("exercises/<uuid:pk>/", ExerciseDetailView.as_view(), name="exercise-detail"),
    path("workouts/<uuid:pk>/", WorkoutDetailView.as_view(), name="workout-detail"),
    path("workouts/<uuid:pk>/start/", WorkoutStartView.as_view(), name="workout-start"),
    path("workouts/<uuid:pk>/complete/", WorkoutCompleteView.as_view(), name="workout-complete"),
]
