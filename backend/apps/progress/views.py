from datetime import timedelta

from django.db.models import Sum
from django.utils import timezone
from drf_spectacular.utils import extend_schema
from rest_framework.generics import ListAPIView
from rest_framework.response import Response
from rest_framework.views import APIView

from .models import ProgramProgress, WorkoutLog
from .serializers import StatsSerializer, WorkoutHistorySerializer


class WorkoutHistoryView(ListAPIView):
    """
    GET /v1/progress/history/
    The current user's completed workout sessions, most recent first.
    """

    serializer_class = WorkoutHistorySerializer

    def get_queryset(self):
        return (
            WorkoutLog.objects.filter(
                user=self.request.user,
                tenant=self.request.tenant,
                completed_at__isnull=False,
            )
            .select_related("workout")
            .prefetch_related("exercise_logs__exercise")
        )


class StatsView(APIView):
    """
    GET /v1/progress/stats/
    Aggregated stats: total workouts, total duration, streaks, active programs.
    """

    @extend_schema(responses={200: StatsSerializer})
    def get(self, request):
        logs = WorkoutLog.objects.filter(
            user=request.user,
            tenant=request.tenant,
            completed_at__isnull=False,
        )

        total_workouts = logs.count()
        total_duration = logs.aggregate(
            total=Sum("duration_seconds", default=0),
        )["total"]

        # Calculate streaks from workout dates
        dates = sorted(
            logs.values_list("completed_at__date", flat=True).distinct()
        )
        current_streak, longest_streak = self._calculate_streaks(dates)

        active_programs = ProgramProgress.objects.filter(
            user=request.user,
            tenant=request.tenant,
            is_active=True,
        ).count()

        data = {
            "total_workouts": total_workouts,
            "total_duration_seconds": total_duration,
            "current_streak": current_streak,
            "longest_streak": longest_streak,
            "active_programs": active_programs,
        }
        return Response(StatsSerializer(data).data)

    def _calculate_streaks(self, dates):
        """Calculate current and longest streak from a sorted list of dates."""
        if not dates:
            return 0, 0

        longest = 1
        current = 1
        for i in range(1, len(dates)):
            if dates[i] - dates[i - 1] == timedelta(days=1):
                current += 1
                longest = max(longest, current)
            else:
                current = 1

        # Check if current streak is still active (last workout was today or yesterday)
        today = timezone.now().date()
        if dates[-1] < today - timedelta(days=1):
            current = 0

        return current, longest
