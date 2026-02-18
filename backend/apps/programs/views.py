from django.shortcuts import get_object_or_404
from drf_spectacular.utils import extend_schema
from rest_framework import status
from rest_framework.generics import ListAPIView, RetrieveAPIView
from rest_framework.response import Response
from rest_framework.views import APIView

from apps.progress.models import ProgramProgress

from .models import Program
from .serializers import (
    ProgramDetailSerializer,
    ProgramListSerializer,
    ProgramProgressSerializer,
)


class ProgramListView(ListAPIView):
    """
    GET /v1/programs/
    List published programs for the current tenant.
    Supports ?difficulty= filtering.
    """

    serializer_class = ProgramListSerializer

    def get_queryset(self):
        qs = Program.objects.filter(
            tenant=self.request.tenant,
            is_published=True,
        ).select_related("cover_image")

        difficulty = self.request.query_params.get("difficulty")
        if difficulty:
            qs = qs.filter(difficulty__iexact=difficulty)

        return qs


class ProgramDetailView(RetrieveAPIView):
    """
    GET /v1/programs/{id}/
    Program detail with weeks and days nested.
    """

    serializer_class = ProgramDetailSerializer

    def get_queryset(self):
        return (
            Program.objects.filter(
                tenant=self.request.tenant,
                is_published=True,
            )
            .select_related("cover_image")
            .prefetch_related(
                "weeks__days__workout",
            )
        )


class ProgramEnrollView(APIView):
    """
    POST /v1/programs/{id}/enroll/
    Enroll the current user in a program.
    Returns existing progress if already enrolled.
    """

    @extend_schema(responses={201: ProgramProgressSerializer})
    def post(self, request, pk):
        program = get_object_or_404(
            Program,
            pk=pk,
            tenant=request.tenant,
            is_published=True,
        )

        progress, created = ProgramProgress.objects.get_or_create(
            user=request.user,
            program=program,
            tenant=request.tenant,
            is_active=True,
            defaults={"current_week": 1, "current_day": 1},
        )

        return Response(
            ProgramProgressSerializer(progress).data,
            status=status.HTTP_201_CREATED if created else status.HTTP_200_OK,
        )


class ProgramProgressView(APIView):
    """
    GET /v1/programs/{id}/progress/
    Get the current user's progress in a program.
    """

    @extend_schema(responses={200: ProgramProgressSerializer})
    def get(self, request, pk):
        program = get_object_or_404(
            Program,
            pk=pk,
            tenant=request.tenant,
            is_published=True,
        )

        progress = ProgramProgress.objects.filter(
            user=request.user,
            program=program,
            is_active=True,
        ).first()

        if not progress:
            return Response(
                {"detail": "Not enrolled in this program."},
                status=status.HTTP_404_NOT_FOUND,
            )

        return Response(ProgramProgressSerializer(progress).data)
