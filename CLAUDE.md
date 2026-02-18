# FitLabel — White-Label Fitness App Platform

## Project Overview

FitLabel is a white-label platform that allows fitness influencers to have their own branded mobile app. Each influencer gets a separately deployed app (their own App Store / Play Store listing) with custom branding (logo, colors, app name). The influencer manages all content through a CRM/admin panel.

**Business model:** We build once, white-label many times. Each influencer pays for their own branded instance.

**Two main components:**
1. **Backend + CRM Panel** — Django + Django REST Framework + customized Django Admin
2. **Mobile App** — Flutter (cross-platform iOS & Android)

---

## Tech Stack

### Backend
- **Framework:** Django 5.x + Django REST Framework (DRF)
- **Database:** PostgreSQL
- **Auth:** Django's built-in auth for CRM; JWT (via `djangorestframework-simplejwt`) for mobile API
- **Media Storage:** AWS S3 (or S3-compatible like DigitalOcean Spaces, MinIO for local dev)
- **Video Processing:** Offload to Mux or Cloudflare Stream (do NOT build custom transcoding)
- **Task Queue:** Celery + Redis (for async jobs like video processing callbacks, email sending)
- **Cache:** Redis
- **Admin/CRM:** Django Admin with `django-unfold` or `django-jazzmin` for modern UI

### Mobile
- **Framework:** Flutter 3.x (Dart)
- **State Management:** Riverpod (preferred) or BLoC
- **HTTP Client:** Dio
- **Video Player:** video_player or better_player
- **Local Storage:** shared_preferences for settings, Hive or sqflite for offline data
- **Push Notifications:** Firebase Cloud Messaging (FCM)

### Infrastructure (later)
- **Hosting:** DigitalOcean, Railway, or AWS
- **CI/CD:** GitHub Actions
- **Containerization:** Docker + Docker Compose for local dev

---

## Folder Structure

```
fitlabel/
├── CLAUDE.md                    # This file — project reference
├── docker-compose.yml           # Local dev: postgres, redis, backend
├── .github/
│   └── workflows/               # CI/CD pipelines
│
├── backend/                     # Django project
│   ├── manage.py
│   ├── requirements/
│   │   ├── base.txt             # Shared dependencies
│   │   ├── dev.txt              # Dev-only (debug toolbar, etc.)
│   │   └── prod.txt             # Production-only (gunicorn, etc.)
│   ├── config/                  # Django project config (settings, urls, wsgi)
│   │   ├── __init__.py
│   │   ├── settings/
│   │   │   ├── __init__.py
│   │   │   ├── base.py          # Shared settings
│   │   │   ├── dev.py           # Local dev settings
│   │   │   └── prod.py          # Production settings
│   │   ├── urls.py              # Root URL config
│   │   ├── wsgi.py
│   │   └── asgi.py
│   ├── apps/
│   │   ├── tenants/             # Multi-tenancy: influencer accounts & branding
│   │   │   ├── models.py        # Tenant, BrandingConfig
│   │   │   ├── admin.py
│   │   │   ├── serializers.py
│   │   │   ├── views.py
│   │   │   ├── urls.py
│   │   │   ├── middleware.py     # Tenant resolution middleware
│   │   │   └── tests/
│   │   ├── users/               # End-user accounts (app users)
│   │   │   ├── models.py        # CustomUser (extends AbstractUser)
│   │   │   ├── admin.py
│   │   │   ├── serializers.py
│   │   │   ├── views.py
│   │   │   ├── urls.py
│   │   │   └── tests/
│   │   ├── programs/            # Workout programs & structure
│   │   │   ├── models.py        # Program, ProgramWeek, ProgramDay
│   │   │   ├── admin.py
│   │   │   ├── serializers.py
│   │   │   ├── views.py
│   │   │   ├── urls.py
│   │   │   └── tests/
│   │   ├── workouts/            # Workouts & exercises
│   │   │   ├── models.py        # Workout, Exercise, ExerciseInWorkout
│   │   │   ├── admin.py
│   │   │   ├── serializers.py
│   │   │   ├── views.py
│   │   │   ├── urls.py
│   │   │   └── tests/
│   │   ├── media_library/       # Videos, images, file management
│   │   │   ├── models.py        # MediaFile (video/image with S3 refs)
│   │   │   ├── admin.py
│   │   │   ├── serializers.py
│   │   │   ├── views.py
│   │   │   ├── urls.py
│   │   │   └── tests/
│   │   ├── progress/            # User workout tracking & progress
│   │   │   ├── models.py        # WorkoutLog, ProgramProgress
│   │   │   ├── admin.py
│   │   │   ├── serializers.py
│   │   │   ├── views.py
│   │   │   ├── urls.py
│   │   │   └── tests/
│   │   └── content/             # Generic content (posts, announcements)
│   │       ├── models.py        # Post, Announcement
│   │       ├── admin.py
│   │       ├── serializers.py
│   │       ├── views.py
│   │       ├── urls.py
│   │       └── tests/
│   └── common/                  # Shared utilities
│       ├── models.py            # BaseModel (timestamps, uuid pk, tenant FK)
│       ├── permissions.py       # Custom DRF permissions
│       ├── pagination.py        # Custom pagination classes
│       └── middleware.py        # Shared middleware
│
├── mobile/                      # Flutter project
│   ├── pubspec.yaml
│   ├── lib/
│   │   ├── main.dart
│   │   ├── app/
│   │   │   ├── app.dart         # MaterialApp config, routing
│   │   │   └── theme.dart       # Dynamic theming from tenant branding
│   │   ├── config/
│   │   │   ├── api_config.dart   # Base URLs, endpoints
│   │   │   ├── app_config.dart   # Tenant-specific config (loaded at startup)
│   │   │   └── constants.dart
│   │   ├── core/
│   │   │   ├── network/
│   │   │   │   ├── api_client.dart       # Dio setup, interceptors
│   │   │   │   └── auth_interceptor.dart # JWT attach/refresh
│   │   │   ├── storage/
│   │   │   │   └── local_storage.dart
│   │   │   └── errors/
│   │   │       └── exceptions.dart
│   │   ├── features/
│   │   │   ├── auth/
│   │   │   │   ├── data/        # Repository, data sources
│   │   │   │   ├── domain/      # Models, repository interface
│   │   │   │   └── presentation/ # Screens, widgets, providers
│   │   │   ├── programs/
│   │   │   │   ├── data/
│   │   │   │   ├── domain/
│   │   │   │   └── presentation/
│   │   │   ├── workouts/
│   │   │   │   ├── data/
│   │   │   │   ├── domain/
│   │   │   │   └── presentation/
│   │   │   ├── exercises/
│   │   │   │   ├── data/
│   │   │   │   ├── domain/
│   │   │   │   └── presentation/
│   │   │   ├── profile/
│   │   │   │   ├── data/
│   │   │   │   ├── domain/
│   │   │   │   └── presentation/
│   │   │   └── progress/
│   │   │       ├── data/
│   │   │       ├── domain/
│   │   │       └── presentation/
│   │   └── shared/
│   │       ├── widgets/          # Reusable UI components
│   │       ├── providers/        # Shared Riverpod providers
│   │       └── utils/
│   ├── assets/
│   │   ├── images/
│   │   └── fonts/
│   └── test/
│
└── docs/                        # Additional documentation
    ├── api.md                   # API endpoint documentation
    ├── models.md                # Data model reference
    └── deployment.md            # Deployment & white-label setup guide
```

---

## Data Models

### Core Principle: Multi-Tenancy via Tenant FK
Every content model has a `tenant` ForeignKey. All queries MUST filter by tenant. Use the `TenantMiddleware` to auto-resolve tenant from subdomain or API header.

### Base Model (all models inherit from this)
```
BaseModel (abstract)
├── id: UUID (primary key)
├── tenant: FK → Tenant
├── created_at: DateTime (auto)
└── updated_at: DateTime (auto)
```

### Tenants App
```
Tenant
├── id: UUID
├── name: str (influencer/brand name)
├── slug: str (unique, used for subdomain: slug.fitlabel.com)
├── owner: FK → User (the influencer)
├── is_active: bool
├── created_at: DateTime
│
├── # Branding
├── app_name: str
├── primary_color: str (hex)
├── secondary_color: str (hex)
├── logo: ImageField (S3)
├── splash_image: ImageField (S3)
├── app_store_id: str (nullable, for deployment tracking)
└── play_store_id: str (nullable)
```

### Users App
```
CustomUser (extends AbstractUser)
├── id: UUID
├── email: str (unique, used as username)
├── tenant: FK → Tenant (which app they belong to)
├── role: enum [ADMIN, USER]
│   # ADMIN = the influencer (tenant owner or their team)
│   # USER = end-user / subscriber
├── avatar: ImageField (nullable)
├── date_of_birth: Date (nullable)
├── created_at: DateTime
│
├── # For end users
├── is_premium: bool (default False)
└── subscription_expires_at: DateTime (nullable)
```

### Programs App
```
Program
├── id: UUID
├── tenant: FK → Tenant
├── title: str
├── description: text
├── cover_image: FK → MediaFile (nullable)
├── difficulty: enum [BEGINNER, INTERMEDIATE, ADVANCED]
├── duration_weeks: int
├── is_published: bool (default False)
├── is_free: bool (default True)
├── ordering: int (display order)
├── created_at / updated_at: DateTime

ProgramWeek
├── id: UUID
├── program: FK → Program
├── week_number: int
├── title: str (e.g., "Week 1 - Foundation")

ProgramDay
├── id: UUID
├── week: FK → ProgramWeek
├── day_number: int (1-7)
├── title: str (e.g., "Upper Body Strength")
├── workout: FK → Workout (nullable, rest day if null)
├── is_rest_day: bool (default False)
```

### Workouts App
```
Exercise
├── id: UUID
├── tenant: FK → Tenant
├── name: str (e.g., "Barbell Squat")
├── description: text
├── demo_video: FK → MediaFile (nullable)
├── demo_image: FK → MediaFile (nullable)
├── muscle_groups: JSONField (list of strings: ["quads", "glutes"])
├── equipment: str (nullable, e.g., "barbell", "dumbbell", "bodyweight")
├── instructions: text (step-by-step)
├── created_at / updated_at: DateTime

Workout
├── id: UUID
├── tenant: FK → Tenant
├── title: str
├── description: text (nullable)
├── estimated_duration_minutes: int
├── cover_image: FK → MediaFile (nullable)
├── created_at / updated_at: DateTime

ExerciseInWorkout (through table — ordering & sets/reps config)
├── id: UUID
├── workout: FK → Workout
├── exercise: FK → Exercise
├── ordering: int
├── sets: int
├── reps: str (can be "12" or "8-12" or "AMRAP" or "30 sec")
├── rest_seconds: int (rest between sets)
├── notes: str (nullable, e.g., "Tempo 3-1-2")
├── superset_group: int (nullable, exercises with same number are supersetted)
```

### Media Library App
```
MediaFile
├── id: UUID
├── tenant: FK → Tenant
├── title: str
├── file_type: enum [VIDEO, IMAGE]
├── file: FileField (S3 path)
├── thumbnail: ImageField (S3, auto-generated for videos)
├── duration_seconds: int (nullable, for videos)
├── file_size_bytes: int
├── mime_type: str
├── is_processed: bool (default False, for video transcoding status)
├── external_video_id: str (nullable, Mux/Cloudflare asset ID)
├── external_playback_url: str (nullable, HLS URL from video service)
├── created_at: DateTime
```

### Progress App
```
WorkoutLog
├── id: UUID
├── user: FK → CustomUser
├── tenant: FK → Tenant
├── workout: FK → Workout
├── program_day: FK → ProgramDay (nullable, if done outside program)
├── started_at: DateTime
├── completed_at: DateTime (nullable)
├── duration_seconds: int (nullable)
├── notes: text (nullable, user notes)

ExerciseLog
├── id: UUID
├── workout_log: FK → WorkoutLog
├── exercise: FK → Exercise
├── sets_completed: int
├── reps_per_set: JSONField (e.g., [12, 10, 8])
├── weight_per_set: JSONField (e.g., [60, 65, 70], nullable)
├── weight_unit: enum [KG, LBS]

ProgramProgress
├── id: UUID
├── user: FK → CustomUser
├── program: FK → Program
├── tenant: FK → Tenant
├── current_week: int (default 1)
├── current_day: int (default 1)
├── started_at: DateTime
├── completed_at: DateTime (nullable)
├── is_active: bool (default True)
```

### Content App
```
Post
├── id: UUID
├── tenant: FK → Tenant
├── title: str
├── body: text (supports markdown or rich text)
├── cover_image: FK → MediaFile (nullable)
├── is_published: bool (default False)
├── published_at: DateTime (nullable)
├── is_free: bool (default True)
├── created_at / updated_at: DateTime
```

---

## API Design

### Base URL Pattern
```
https://api.fitlabel.com/v1/
```
Tenant is resolved via:
- `X-Tenant-Slug` header (mobile app sends this), OR
- Subdomain (`acme.api.fitlabel.com`), OR
- JWT token (user's tenant is embedded in the token)

### Endpoints

#### Auth
```
POST   /v1/auth/register/          # New user registration
POST   /v1/auth/login/             # Returns JWT access + refresh tokens
POST   /v1/auth/token/refresh/     # Refresh JWT
POST   /v1/auth/password/reset/    # Request password reset email
POST   /v1/auth/password/confirm/  # Confirm password reset
GET    /v1/auth/me/                # Get current user profile
PATCH  /v1/auth/me/                # Update profile
```

#### Programs
```
GET    /v1/programs/                       # List published programs
GET    /v1/programs/{id}/                  # Program detail with weeks/days
POST   /v1/programs/{id}/enroll/           # Start a program
GET    /v1/programs/{id}/progress/         # User's progress in program
```

#### Workouts
```
GET    /v1/workouts/{id}/                  # Workout detail with exercises
POST   /v1/workouts/{id}/start/            # Start workout session
POST   /v1/workouts/{id}/complete/         # Complete workout, submit log
```

#### Exercises
```
GET    /v1/exercises/                      # List all exercises (for search/browse)
GET    /v1/exercises/{id}/                 # Exercise detail with video URL
```

#### Media
```
GET    /v1/media/{id}/                     # Get media file details + signed URL
```

#### Content
```
GET    /v1/content/posts/                  # List published posts
GET    /v1/content/posts/{id}/             # Post detail
```

#### Branding (for app config on startup)
```
GET    /v1/config/                         # Returns tenant branding, colors, logo URLs
```

#### Progress / History
```
GET    /v1/progress/history/               # User's workout history
GET    /v1/progress/stats/                 # Aggregated stats (total workouts, streaks, etc.)
```

### Admin/CRM Endpoints (for influencer dashboard, if building custom frontend later)
```
# These would be under /v1/admin/ and require ADMIN role
# For MVP, Django Admin handles this — no custom API needed
```

---

## Multi-Tenancy Strategy

**Approach:** Shared database, tenant column on every table.

### How it works:
1. Every model inherits `BaseModel` which has a `tenant` FK
2. `TenantMiddleware` resolves the tenant on every request (from header, subdomain, or JWT)
3. A custom Manager on BaseModel auto-filters by `request.tenant`
4. Django Admin is scoped — influencers only see their own data
5. API serializers/views always filter by `request.tenant`

### Middleware flow:
```
Request → TenantMiddleware → resolve tenant → attach to request.tenant → View
```

### Admin scoping:
- Superusers (us, the platform owners) see everything
- Influencers (staff users with ADMIN role) see only their tenant's data
- Override `get_queryset()` in every ModelAdmin to filter by tenant

---

## Development Phases

### Phase 1 — MVP
**Goal:** One influencer can manage content, their users can browse and follow programs.

Backend:
- [ ] Django project setup with split settings (dev/prod)
- [ ] PostgreSQL + Docker Compose for local dev
- [ ] Tenant model + middleware
- [ ] CustomUser model with JWT auth
- [ ] Exercise, Workout, ExerciseInWorkout models + admin
- [ ] Program, ProgramWeek, ProgramDay models + admin
- [ ] MediaFile model with S3 upload in admin
- [ ] REST API for all read endpoints (programs, workouts, exercises, config)
- [ ] Auth API (register, login, refresh, me)
- [ ] Progress tracking API (start/complete workout, enroll in program)
- [ ] Basic Django Admin customization for influencer use

Mobile:
- [ ] Flutter project setup with folder structure
- [ ] API client (Dio) with JWT interceptor
- [ ] Auth flow (login, register, token storage)
- [ ] App config loading (branding/colors from /v1/config/)
- [ ] Dynamic theming based on tenant branding
- [ ] Programs list screen
- [ ] Program detail screen (weeks → days → workouts)
- [ ] Workout screen (exercise list with video player)
- [ ] Basic progress tracking (mark workout complete)
- [ ] Profile screen

### Phase 2 — Monetization
- [ ] Stripe Connect integration (each influencer gets connected account)
- [ ] Subscription model + plans (tenant-configurable)
- [ ] Paywall logic (is_free flag on programs/posts)
- [ ] In-app purchase flow
- [ ] Subscription management in CRM

### Phase 3 — Engagement
- [ ] Push notifications (FCM) with admin send UI
- [ ] Workout streaks & stats dashboard in app
- [ ] Posts/announcements feed in app
- [ ] Challenge system (time-limited programs with leaderboard)

### Phase 4 — Scale
- [ ] Self-service influencer onboarding
- [ ] Analytics dashboard in CRM (subscribers, revenue, engagement)
- [ ] Nutrition/meal plan module
- [ ] App store deployment automation (Fastlane + flavor builds)

---

## Key Technical Decisions

### Video Hosting
Do NOT self-host videos. Use Mux or Cloudflare Stream:
- They handle transcoding to multiple resolutions
- Provide HLS streaming URLs
- Handle CDN delivery globally
- Cost is reasonable at scale
- Store the `external_video_id` and `external_playback_url` in MediaFile

### White-Label App Deployment
Each influencer's app is built using Flutter flavors:
- One codebase, multiple build configurations
- Each flavor overrides: app name, bundle ID, icon, splash, default API tenant slug
- Use Fastlane for automated builds and App Store / Play Store deployment
- This is Phase 4 complexity — for MVP, build one app with runtime config

### For MVP: Runtime Branding
Instead of separate builds, the MVP app loads branding at startup from `/v1/config/`:
- Colors, logo, app name come from the API
- Single app binary, multiple tenants
- Good enough to demo and get first customers
- Move to flavor-based builds when you need separate App Store listings

---

## Coding Conventions

### Backend (Django)
- Use class-based views (APIView or ViewSet) in DRF
- Fat models, thin views — business logic goes in model methods or service layer
- Every queryset must be tenant-filtered
- Write serializers for all API responses (no raw dicts)
- Use `select_related` and `prefetch_related` to avoid N+1 queries
- Tests in each app's `tests/` folder using pytest-django
- Environment variables for all secrets (use django-environ)

### Mobile (Flutter)
- Feature-first folder structure (not layer-first)
- Repository pattern: data sources → repositories → providers → UI
- All API calls go through the Dio client, never raw http
- Use Riverpod for dependency injection and state
- Separate domain models from API response DTOs
- Avoid putting logic in widgets — extract to providers/controllers

### Git
- `main` branch is production
- `develop` branch for integration
- Feature branches: `feature/backend-auth`, `feature/mobile-programs`
- Conventional commits: `feat:`, `fix:`, `chore:`, `docs:`

---

## Local Development Setup

### Prerequisites
- Python 3.12+
- Flutter 3.x + Dart
- Docker & Docker Compose
- Node.js (for any tooling)

### Backend
```bash
cd backend
python -m venv venv
source venv/bin/activate
pip install -r requirements/dev.txt
# Start postgres + redis
docker compose up -d db redis
python manage.py migrate
python manage.py createsuperuser
python manage.py runserver
```

### Mobile
```bash
cd mobile
flutter pub get
flutter run
```

### Docker Compose services (for local dev)
```yaml
services:
  db:
    image: postgres:16
    environment:
      POSTGRES_DB: fitlabel
      POSTGRES_USER: fitlabel
      POSTGRES_PASSWORD: fitlabel
    ports:
      - "5432:5432"
  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
```

---

## Important Notes for Claude Code

- Always check multi-tenancy: every query must filter by tenant
- Never expose internal IDs in URLs — use UUIDs
- Always return proper HTTP status codes (201 for create, 204 for delete, etc.)
- Paginate all list endpoints (use cursor pagination for mobile)
- Use Django signals sparingly — prefer explicit method calls
- For S3 uploads: use presigned URLs so files go directly from client to S3
- Keep the admin simple — django-unfold for styling, inline models for nested editing
- When writing Flutter code, always handle loading/error/empty states
- Mobile API responses should be as lean as possible (don't send data the screen doesn't need)
