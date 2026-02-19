# Backend Development Concepts — FitLabel

A running log of backend concepts and patterns used while building FitLabel. Each section explains *what* was done, *why*, and where to find it in the codebase.

---

## Table of Contents

1. [Multi-Tenancy](#1-multi-tenancy)
2. [Middleware](#2-middleware)
3. [Abstract Base Models](#3-abstract-base-models)
4. [UUIDs vs Auto-Increment IDs](#4-uuids-vs-auto-increment-ids)
5. [Foreign Keys and Relationships](#5-foreign-keys-and-relationships)
6. [on_delete Behavior](#6-on_delete-behavior)
7. [JWT Authentication](#7-jwt-authentication)
8. [Serializers](#8-serializers)
9. [Permission Classes](#9-permission-classes)
10. [Admin Scoping (Row-Level Security)](#10-admin-scoping-row-level-security)
11. [Split Settings](#11-split-settings)
12. [Environment Variables](#12-environment-variables)
13. [Cursor Pagination](#13-cursor-pagination)
14. [API Documentation (OpenAPI/Swagger)](#14-api-documentation-openapiswagger)
15. [Generic Views](#15-generic-views-listcreateapiview-retrieveapiview)
16. [Lean List, Rich Detail](#16-lean-list-rich-detail-api-response-design)
17. [Nested Serializers](#17-nested-serializers-tree-structures-in-one-request)
18. [select_related vs prefetch_related](#18-select_related-vs-prefetch_related-n1-query-prevention)
19. [Idempotent Endpoints](#19-idempotent-endpoints-safe-to-retry)
20. [bulk_create](#20-bulk_create-batch-database-inserts)
21. [Database Aggregation](#21-database-aggregation-aggregate-and-annotate)
22. [Streak Calculation](#22-streak-calculation-when-sql-isnt-the-best-tool)
23. [get_object_or_404](#23-get_object_or_404-clean-error-handling)

---

## 1. Multi-Tenancy

**What:** Multiple customers (influencers) share one database, but each row has a `tenant` foreign key so their data never mixes.

**Where:** `common/models.py` — `BaseModel`, `apps/tenants/middleware.py` — `TenantMiddleware`

```python
# Every content model inherits this
class BaseModel(models.Model):
    tenant = models.ForeignKey("tenants.Tenant", ...)
```

**Why:** The alternative is a separate database per customer — much harder to manage, migrate, and scale. The shared-DB approach means one deployment serves everyone, but every query must filter by tenant. That's why the middleware and admin scoping exist.

**Trade-offs:**
- Simpler deployment and migrations (one DB to manage)
- Must be disciplined about filtering — one missed `.filter(tenant=...)` leaks data across tenants
- At very large scale, can shard later by moving specific tenants to dedicated DBs

---

## 2. Middleware

**What:** Code that runs on every request before it hits your view. A series of gates the request passes through.

**Where:** `apps/tenants/middleware.py`, `config/settings/base.py` (MIDDLEWARE list)

```
Request → SecurityMiddleware → CorsMiddleware → SessionMiddleware → ...
  → AuthenticationMiddleware → TenantMiddleware → Your View
```

**Why:** Middleware separates cross-cutting concerns (auth, CORS, tenant resolution) from business logic. Views stay clean because they can assume `request.tenant` already exists.

**Our TenantMiddleware resolves tenant via 3 strategies (in order):**
1. `X-Tenant-Slug` header (mobile app sends this)
2. Subdomain parsing (`acme.api.fitlabel.com`)
3. Authenticated user's tenant (from JWT)

**Key detail:** Order matters — TenantMiddleware comes after AuthenticationMiddleware because strategy 3 needs `request.user` to be populated.

---

## 3. Abstract Base Models

**What:** A model with `abstract = True` that other models inherit from. No database table is created for the abstract model itself — its fields are injected into child models.

**Where:** `common/models.py`

```python
class BaseModel(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4)
    tenant = models.ForeignKey(...)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True  # no table for BaseModel
```

**Why:** Every content model (MediaFile, Exercise, Workout, Program, Post, etc.) gets these 4 fields automatically. Without this, you'd copy-paste them into every model and inevitably forget one. This is model-level DRY ("Don't Repeat Yourself").

**Who inherits BaseModel:** MediaFile, Exercise, Workout, Program, WorkoutLog, ProgramProgress, Post

**Who does NOT:** Tenant (it *is* the tenant — no tenant FK on itself), CustomUser (extends Django's AbstractUser instead), ExerciseInWorkout/ExerciseLog/ProgramWeek/ProgramDay (scoped through their parent model)

---

## 4. UUIDs vs Auto-Increment IDs

**What:** Using random UUIDs (`550e8400-e29b-41d4-a716-446655440000`) instead of sequential integers (`1, 2, 3...`) as primary keys.

**Where:** `common/models.py`, `apps/users/models.py`, `apps/tenants/models.py`

```python
id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
```

**Why:**
- **Security:** Users can't guess other records by incrementing (`/users/1` → `/users/2`)
- **Multi-system safety:** If you ever merge databases or sync across services, UUIDs won't collide
- **No information leakage:** Sequential IDs reveal how many records exist (user #50000 tells competitors your user count)

**Trade-off:** UUIDs are larger (16 bytes vs 4-8 bytes) and slightly slower for indexing. For our scale, this is negligible.

---

## 5. Foreign Keys and Relationships

**What:** Database-level links between models. Three types used throughout the project.

**Where:** Every model file

### One-to-Many
```python
# A tenant has many users, a user belongs to one tenant
tenant = models.ForeignKey("tenants.Tenant", on_delete=models.CASCADE)
```

### One-to-Many (Optional)
```python
# Exercise may or may not have a demo video
demo_video = models.ForeignKey("media_library.MediaFile", null=True, blank=True, on_delete=models.SET_NULL)
```

### Many-to-Many with Through Table
```python
# A workout has many exercises, an exercise appears in many workouts
exercises = models.ManyToManyField(Exercise, through="ExerciseInWorkout")
```

**Why the through table:** A plain ManyToManyField can only say "these are linked." The through table (`ExerciseInWorkout`) stores extra data about the relationship: ordering, sets, reps, rest time, superset groups. This is how the influencer configures "3 sets of 12 reps with 60s rest" for a specific exercise in a specific workout.

**`related_name`:** Lets you traverse the relationship backwards. `workout.exercise_entries.all()` gets all ExerciseInWorkout rows for that workout.

---

## 6. on_delete Behavior

**What:** Every ForeignKey must declare what happens when the referenced object is deleted.

**Where:** Every model with a ForeignKey

| Behavior | Meaning | When to use |
|---|---|---|
| `CASCADE` | Delete this record too | Child data that's meaningless without parent (user deleted → their logs deleted) |
| `SET_NULL` | Set FK to null, keep the record | Optional references (media file deleted → exercise keeps existing, just loses its demo video) |
| `PROTECT` | Block the deletion entirely | Critical references you never want to accidentally remove |

**Why it matters:** Choosing wrong can either orphan data (dangling references) or accidentally delete too much (cascading through half your database).

---

## 7. JWT Authentication

**What:** JSON Web Tokens — a stateless authentication mechanism where all user info is encoded in the token itself.

**Where:** `apps/users/serializers.py` (CustomTokenObtainPairSerializer), `config/settings/base.py` (SIMPLE_JWT config)

### How it works
1. User sends email + password to `/v1/auth/login/`
2. Server verifies credentials, creates a JWT signed with `SECRET_KEY`
3. Client stores the token and sends it with every request: `Authorization: Bearer <token>`
4. Server verifies the signature — no database lookup needed

### What's inside our JWT payload
```json
{
    "user_id": "7f17b7ae-...",
    "role": "USER",
    "tenant_id": "bae40b6e-...",
    "tenant_slug": "test-gym",
    "exp": 1771417032
}
```

### Access + Refresh pattern
- **Access token:** Short-lived (30 min). Used for API requests.
- **Refresh token:** Long-lived (7 days). Used only to get a new access token.
- **Why:** If an access token is stolen, the damage window is 30 minutes. The refresh token is only sent to one endpoint, reducing exposure.

### Sessions vs JWT
| Sessions | JWT |
|---|---|
| Server stores login state | Token contains all info |
| Uses cookies | Uses Authorization header |
| Requires DB lookup per request | Stateless verification |
| Better for web apps | Better for mobile/API |

**Why JWT for us:** Mobile apps don't use cookies. JWT lets the app work offline (it knows the user's role and tenant from the token) and doesn't require server-side session storage.

---

## 8. Serializers

**What:** The boundary between your database and the outside world. They handle both input validation and output formatting.

**Where:** `apps/users/serializers.py`, `apps/tenants/serializers.py`

### Input validation
```python
class RegisterSerializer(serializers.Serializer):
    email = serializers.EmailField()              # must be valid email format
    password = serializers.CharField(min_length=8) # at least 8 chars
    tenant_slug = serializers.SlugField()          # validated against DB
```

### Output formatting
```python
class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        fields = ["id", "email", "first_name", ...]       # only these fields are sent
        read_only_fields = ["id", "email", "role", ...]    # can't be changed via API
```

**Why not return the model directly?**
- You'd expose internal fields (password hashes, internal flags)
- No validation on input (anyone could submit anything)
- No control over what the API returns (data leakage)
- Response shape is coupled to database schema (changing a column breaks the API)

**Key principle:** Serializers are your API contract. The database schema can change without breaking clients, as long as the serializer keeps the same shape.

---

## 9. Permission Classes

**What:** Declarative access control on views. You state the rule, the framework enforces it before your view code runs.

**Where:** `common/permissions.py`, every view class

```python
class RegisterView(APIView):
    permission_classes = [AllowAny]        # anyone, no token needed

class MeView(APIView):
    permission_classes = [IsAuthenticated]   # must have valid JWT
```

### Custom permissions (for future use)
```python
class IsAdminRole(BasePermission):     # only influencers (ADMIN role)
class IsTenantMember(BasePermission)   # user must belong to request's tenant
```

**Why declarative:** Permissions are checked automatically by DRF before the view method executes. You can't accidentally forget to check — if the permission fails, the view never runs. Compare this to manually writing `if not request.user.is_authenticated: return 403` in every view.

---

## 10. Admin Scoping (Row-Level Security)

**What:** Filtering what each admin user can see based on their tenant.

**Where:** Every `admin.py` file

```python
def get_queryset(self, request):
    qs = super().get_queryset(request)
    if request.user.is_superuser:
        return qs                                 # platform admins see everything
    return qs.filter(tenant=request.user.tenant)   # influencers see only their data
```

**Why:** Without this, an influencer logging into the admin would see every other influencer's exercises, workouts, and users. Same database table, different view depending on who's asking.

**Also applies to `save_model`:** When an influencer creates a new record, we auto-assign their tenant so they can't accidentally (or maliciously) create data under another tenant.

---

## 11. Split Settings

**What:** Separate settings files for different environments that inherit from a shared base.

**Where:** `config/settings/`

```
config/settings/
├── base.py    # shared: installed apps, middleware, auth, DB config
├── dev.py     # imports base, adds: debug toolbar, CORS allow all, DEBUG=True
└── prod.py    # imports base, adds: SSL redirect, HSTS, WhiteNoise
```

**Why:** You never want `DEBUG=True` in production (it exposes tracebacks to users), and you don't want SSL enforcement breaking local dev. Splitting settings means the same codebase works in both environments without scattered `if DEBUG:` statements.

**How it's selected:** `manage.py` defaults to `config.settings.dev`. Production overrides this with an environment variable: `DJANGO_SETTINGS_MODULE=config.settings.prod`.

---

## 12. Environment Variables

**What:** Externalized configuration — secrets and environment-specific values live outside the code.

**Where:** `.env` file (gitignored), `.env.example` (committed as template), `config/settings/base.py`

```python
SECRET_KEY = env("DJANGO_SECRET_KEY")
DATABASES = {"default": env.db("DATABASE_URL")}
```

**Why:**
- Secrets never end up in git (`.env` is in `.gitignore`)
- Different environments use different values (dev DB vs prod DB)
- `.env.example` documents what's needed without exposing actual values
- Follows the [Twelve-Factor App](https://12factor.net/config) methodology

**Rule of thumb:** If a value would be different between your laptop and the production server, it belongs in an environment variable.

---

## 13. Cursor Pagination

**What:** A pagination strategy that uses an opaque cursor (pointer) instead of page numbers.

**Where:** `common/pagination.py`

```python
class CursorPagination(BaseCursorPagination):
    page_size = 20
    ordering = "-created_at"
```

### Page numbers vs Cursor
| Page numbers | Cursor |
|---|---|
| `?page=1`, `?page=2` | `?cursor=abc123` |
| If new data is inserted, items shift and you get duplicates | Stable — always picks up where you left off |
| User can jump to any page | Can only go forward/backward |
| Good for web dashboards | Good for infinite scroll (mobile) |

**Why cursor for us:** Mobile apps use infinite scroll. If a new post is published while the user scrolls, page-number pagination would shift everything and show duplicates. Cursor pagination is immune to this.

---

## 14. API Documentation (OpenAPI/Swagger)

**What:** Auto-generated interactive API docs from your code, using the OpenAPI standard.

**Where:** `config/urls.py` (routes), drf-spectacular config in `config/settings/base.py`

- `/api/docs/` — Swagger UI (interactive, test endpoints in the browser)
- `/api/schema/` — Raw OpenAPI YAML (importable into Postman)

**Why:** Without docs, every frontend/mobile developer has to read your code or ask you how each endpoint works. Swagger generates docs automatically from your serializers, views, and URL patterns.

**`@extend_schema` decorator:** When drf-spectacular can't auto-detect the request/response shape (custom APIViews), you annotate the view explicitly:

```python
@extend_schema(
    request=RegisterSerializer,
    responses={201: TokenResponseSerializer},
)
def post(self, request):
    ...
```

This keeps the docs accurate without maintaining a separate spec file.

---

## 15. Generic Views (ListAPIView, RetrieveAPIView)

**What:** DRF provides pre-built view classes that handle common patterns so you don't rewrite the same logic.

**Where:** `apps/workouts/views.py`, `apps/programs/views.py`, `apps/content/views.py`, `apps/progress/views.py`

```python
class ExerciseListView(ListAPIView):
    serializer_class = ExerciseListSerializer

    def get_queryset(self):
        return Exercise.objects.filter(tenant=self.request.tenant)


class ExerciseDetailView(RetrieveAPIView):
    serializer_class = ExerciseDetailSerializer

    def get_queryset(self):
        return Exercise.objects.filter(tenant=self.request.tenant)
```

**What each class gives you for free:**
| Class | HTTP Method | What it does |
|---|---|---|
| `ListAPIView` | GET | Queryset → serialization → pagination → response |
| `RetrieveAPIView` | GET | Lookup by pk → serialization → response (or 404) |
| `APIView` | Any | Raw view — you handle everything manually |

**When to use which:**
- **Generic views** (`ListAPIView`, `RetrieveAPIView`): Standard CRUD with a queryset. Pagination, serialization, and 404 handling are automatic.
- **`APIView`**: Custom logic that doesn't fit the queryset pattern (e.g., enrolling in a program, starting a workout, computing stats). You write the full method.

**Why `get_queryset()` instead of `queryset = ...`:** The queryset attribute is evaluated once at import time. `get_queryset()` runs per-request, so it can access `self.request.tenant` to filter by the current tenant. If you used `queryset = Exercise.objects.all()`, there would be no tenant filtering.

---

## 16. Lean List, Rich Detail (API Response Design)

**What:** List endpoints return minimal fields. Detail endpoints return everything. The same model gets two different serializers.

**Where:** Every app with list + detail endpoints

```python
# List: just enough to render a card in the mobile app
class ExerciseListSerializer(serializers.ModelSerializer):
    class Meta:
        fields = ["id", "name", "muscle_groups", "equipment", "demo_image"]

# Detail: full data when user taps into it
class ExerciseDetailSerializer(serializers.ModelSerializer):
    class Meta:
        fields = ["id", "name", "description", "demo_video", "demo_image",
                  "muscle_groups", "equipment", "instructions"]
```

**Why:** A list loads 20 items at once. If each item carried full descriptions, instructions, and video URLs, that's a lot of wasted bandwidth — especially on mobile. The app shows a scrollable list of cards (name + thumbnail), then fetches the full detail only when the user taps one.

**Applied consistently across:**
| App | List omits | Detail includes |
|---|---|---|
| Exercises | description, instructions, video | Everything |
| Programs | description, weeks/days tree | Full nested structure |
| Posts | body (could be thousands of chars of markdown) | Full body |

---

## 17. Nested Serializers (Tree Structures in One Request)

**What:** Serializers containing other serializers, building a tree structure from a single API call.

**Where:** `apps/programs/serializers.py`, `apps/workouts/serializers.py`

```python
class ProgramDaySerializer(serializers.ModelSerializer):
    ...

class ProgramWeekSerializer(serializers.ModelSerializer):
    days = ProgramDaySerializer(many=True, read_only=True)   # nested

class ProgramDetailSerializer(serializers.ModelSerializer):
    weeks = ProgramWeekSerializer(many=True, read_only=True)  # nested
```

**Result:** One `GET /v1/programs/{id}/` returns:
```json
{
  "title": "8-Week Strength",
  "weeks": [
    {
      "week_number": 1,
      "days": [
        { "day_number": 1, "title": "Full Body", "workout_id": "..." },
        { "day_number": 2, "title": "Rest", "is_rest_day": true }
      ]
    }
  ]
}
```

**Why not separate endpoints?** The mobile app needs the full program structure to render the program detail screen. Three separate requests (`/program`, `/program/weeks`, `/program/weeks/1/days`) would be slower and more complex. One request with nested data is simpler for the client.

**Trade-off:** Nested responses can get large. For a program with 8 weeks × 7 days = 56 day objects — still reasonable. For truly large datasets, you'd paginate the nested items or use separate endpoints.

---

## 18. select_related vs prefetch_related (N+1 Query Prevention)

**What:** Two Django ORM methods that pre-load related objects to avoid the "N+1 query problem."

**Where:** Every view with related data

### The N+1 problem
```python
# BAD: 1 query for workouts + 1 query per workout to get cover_image = N+1 queries
for workout in Workout.objects.all():
    print(workout.cover_image.title)  # each access hits the DB
```

### select_related (single FK, uses SQL JOIN)
```python
# GOOD: 1 query with JOIN — for ForeignKey / OneToOneField
Exercise.objects.filter(...).select_related("demo_video", "demo_image")
```
Use when: the relationship is a single object (ForeignKey going "forward").

### prefetch_related (reverse FK or M2M, uses separate query)
```python
# GOOD: 2 queries — one for workouts, one for all their exercise_entries
Workout.objects.filter(...).prefetch_related("exercise_entries__exercise__demo_image")
```
Use when: the relationship is one-to-many (reverse FK) or many-to-many. Can chain with `__` to follow multiple levels.

### How we use both together
```python
# Program detail: JOIN for cover_image, separate queries for weeks→days→workout
Program.objects.filter(...)
    .select_related("cover_image")
    .prefetch_related("weeks__days__workout")
```
This executes 4 queries total (program+cover, weeks, days, workouts) regardless of how many weeks/days exist. Without it, a program with 8 weeks and 56 days would run 65+ queries.

---

## 19. Idempotent Endpoints (Safe to Retry)

**What:** An endpoint that produces the same result whether you call it once or ten times.

**Where:** `apps/programs/views.py` — `ProgramEnrollView`

```python
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
```

**How `get_or_create` works:**
1. Try to find an existing row matching the lookup fields
2. If found → return it (no changes made)
3. If not found → create it with the `defaults` values

**Why this matters for mobile:** Network requests can fail mid-flight. The user taps "Enroll," the request succeeds on the server but the response is lost due to bad connectivity. The app retries — without idempotency, you'd get a duplicate enrollment or an error. With `get_or_create`, the retry harmlessly returns the existing enrollment.

**Status code convention:** `201 Created` on first enrollment, `200 OK` on subsequent calls. The client knows whether it was new or existing.

---

## 20. bulk_create (Batch Database Inserts)

**What:** Insert multiple rows in a single SQL statement instead of one INSERT per row.

**Where:** `apps/workouts/views.py` — `WorkoutCompleteView`

```python
# Instead of this (N queries):
for entry in exercise_logs:
    ExerciseLog.objects.create(workout_log=log, exercise_id=entry["exercise_id"], ...)

# We do this (1 query):
exercise_logs = [ExerciseLog(...) for entry in data]
ExerciseLog.objects.bulk_create(exercise_logs)
```

**Why:** A workout might have 8-10 exercises. That's 8-10 separate INSERT statements vs. one. At scale, this reduces database round-trips significantly. The difference is small for one user, but when hundreds of users complete workouts simultaneously, it adds up.

**Limitation:** `bulk_create` doesn't call the model's `save()` method or trigger signals. If you have custom save logic, use individual creates instead.

---

## 21. Database Aggregation (aggregate and annotate)

**What:** Push calculations to the database instead of loading all rows into Python.

**Where:** `apps/progress/views.py` — `StatsView`

```python
total_workouts = logs.count()                              # SELECT COUNT(*)
total_duration = logs.aggregate(
    total=Sum("duration_seconds", default=0),              # SELECT SUM(duration_seconds)
)["total"]
```

**Why not load all logs and sum in Python?**
```python
# BAD: loads every row into memory, then sums in Python
all_logs = list(WorkoutLog.objects.filter(...))
total = sum(log.duration_seconds or 0 for log in all_logs)

# GOOD: database does the math, returns one number
total = logs.aggregate(total=Sum("duration_seconds", default=0))["total"]
```

The database is optimized for this. If a user has 500 workout logs, the bad approach loads 500 rows into Python memory. The good approach asks PostgreSQL to add up one column and return a single integer.

**`aggregate` vs `annotate`:**
| Method | Returns | Use when |
|---|---|---|
| `aggregate()` | A dictionary `{"total": 12345}` | You want one summary value for the whole queryset |
| `annotate()` | A queryset with extra computed fields on each row | You want a computed value per row (e.g., exercise count per workout) |

---

## 22. Streak Calculation (When SQL Isn't the Best Tool)

**What:** Computing consecutive-day workout streaks in Python instead of SQL.

**Where:** `apps/progress/views.py` — `StatsView._calculate_streaks`

```python
dates = sorted(logs.values_list("completed_at__date", flat=True).distinct())

current = 1
longest = 1
for i in range(1, len(dates)):
    if dates[i] - dates[i - 1] == timedelta(days=1):
        current += 1
        longest = max(longest, current)
    else:
        current = 1

# Streak is broken if last workout wasn't today or yesterday
if dates[-1] < today - timedelta(days=1):
    current = 0
```

**Why Python over SQL:** Consecutive-day detection in SQL requires window functions (`LAG`, `PARTITION BY`, `ROW_NUMBER`) which are harder to read, debug, and test. The dataset is small (distinct dates — max 365 per year), so pulling them into Python is negligible overhead. The Python loop is immediately readable: "if the gap is one day, extend the streak; otherwise reset."

**Key detail:** `values_list("completed_at__date", flat=True).distinct()` asks the database for just the unique dates (not full rows), which is efficient even with thousands of workout logs.

**Rule of thumb:** Use SQL aggregation for math (SUM, COUNT, AVG). Use Python for sequential logic (streaks, state machines, complex conditionals).

---

## 23. get_object_or_404 (Clean Error Handling)

**What:** A shortcut that returns a model instance or automatically raises a 404 response.

**Where:** `apps/workouts/views.py`, `apps/programs/views.py`

```python
# Instead of:
try:
    workout = Workout.objects.get(pk=pk, tenant=request.tenant)
except Workout.DoesNotExist:
    return Response({"detail": "Not found."}, status=404)

# Use:
workout = get_object_or_404(Workout, pk=pk, tenant=request.tenant)
```

**Why:** Less boilerplate, consistent 404 responses. DRF catches the `Http404` exception and returns a proper JSON error response automatically. You'll see this in almost every Django view that looks up a specific object.

---

## Concepts Log

*New concepts will be added here as development continues.*

| Date | Concept | Where it was applied |
|---|---|---|
| 2026-02-18 | Project scaffolding, split settings, env vars | `config/`, `.env` |
| 2026-02-18 | Multi-tenancy, middleware, tenant resolution | `common/models.py`, `apps/tenants/middleware.py` |
| 2026-02-18 | JWT auth with custom claims | `apps/users/serializers.py`, `apps/users/views.py` |
| 2026-02-18 | Abstract base models, UUIDs | `common/models.py` |
| 2026-02-18 | Foreign keys, through tables, on_delete | `apps/workouts/models.py`, `apps/programs/models.py` |
| 2026-02-18 | Admin scoping, inline editing | Every `admin.py` |
| 2026-02-18 | Serializers, permissions, cursor pagination | `apps/users/`, `common/` |
| 2026-02-18 | OpenAPI/Swagger docs | `config/urls.py`, `@extend_schema` decorators |
| 2026-02-18 | Generic views (ListAPIView, RetrieveAPIView) | `apps/workouts/views.py`, `apps/content/views.py` |
| 2026-02-18 | Lean list / rich detail pattern | Every app with list + detail serializers |
| 2026-02-18 | Nested serializers (tree structures) | `apps/programs/serializers.py`, `apps/workouts/serializers.py` |
| 2026-02-18 | select_related vs prefetch_related (N+1 prevention) | Every view with related data |
| 2026-02-18 | Idempotent endpoints (get_or_create) | `apps/programs/views.py` |
| 2026-02-18 | bulk_create (batch inserts) | `apps/workouts/views.py` |
| 2026-02-18 | Database aggregation (aggregate, Sum) | `apps/progress/views.py` |
| 2026-02-18 | Streak calculation (Python vs SQL trade-off) | `apps/progress/views.py` |
| 2026-02-18 | get_object_or_404 | `apps/workouts/views.py`, `apps/programs/views.py` |
