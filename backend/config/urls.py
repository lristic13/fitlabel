from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import include, path
from drf_spectacular.views import SpectacularAPIView, SpectacularSwaggerView

urlpatterns = [
    path("admin/", admin.site.urls),
    path("v1/auth/", include("apps.users.urls")),
    path("v1/config/", include("apps.tenants.urls")),
    path("v1/", include("apps.workouts.urls")),
    path("v1/", include("apps.programs.urls")),
    path("v1/content/", include("apps.content.urls")),
    path("v1/progress/", include("apps.progress.urls")),
    # API docs
    path("api/schema/", SpectacularAPIView.as_view(), name="schema"),
    path("api/docs/", SpectacularSwaggerView.as_view(url_name="schema"), name="swagger-ui"),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

    if "debug_toolbar" in settings.INSTALLED_APPS:
        urlpatterns.append(path("__debug__/", include("debug_toolbar.urls")))
