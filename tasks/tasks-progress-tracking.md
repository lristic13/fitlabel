## Relevant Files

- `mobile/lib/features/progress/domain/models/progress.dart` - Freezed models for WorkoutHistory, ExerciseLog, and ProgressStats
- `mobile/lib/features/progress/domain/repositories/progress_repository.dart` - Abstract repository contract
- `mobile/lib/features/progress/data/datasources/progress_remote_data_source.dart` - API calls to /v1/progress/history/ and /v1/progress/stats/
- `mobile/lib/features/progress/data/repositories/progress_repository_impl.dart` - Repository implementation mapping JSON to domain models
- `mobile/lib/features/progress/presentation/providers/progress_provider.dart` - Riverpod providers for history list, stats, and pagination
- `mobile/lib/features/progress/presentation/widgets/history_card.dart` - Card widget for a single workout history entry
- `mobile/lib/features/progress/presentation/widgets/stats_card.dart` - Card widget for displaying a single stat (streak, total, etc.)
- `mobile/lib/features/progress/presentation/screens/history_tab.dart` - History sub-tab with infinite scroll list
- `mobile/lib/features/progress/presentation/screens/stats_tab.dart` - Stats sub-tab with streak and total cards
- `mobile/lib/features/profile/presentation/screens/profile_screen.dart` - Existing profile screen, refactored to add TabBar with sub-tabs
- `mobile/lib/core/network/api_client.dart` - May need a new method for cursor-paginated fetching (returns next cursor + results)

### Notes

- Follow the same clean architecture pattern as Programs/Posts: domain models (freezed) → repository → data source → Riverpod providers → presentation.
- Run `dart run build_runner build --delete-conflicting-outputs` after creating freezed models and Riverpod providers to generate `.freezed.dart`, `.g.dart` files.
- Run `flutter analyze` to verify no errors after all changes.

## Instructions for Completing Tasks

**IMPORTANT:** As you complete each task, you must check it off in this markdown file by changing `- [ ]` to `- [x]`. This helps track progress and ensures you don't skip any steps.

Example:
- `- [ ] 1.1 Read file` → `- [x] 1.1 Read file` (after completing)

Update the file after completing each sub-task, not just after completing an entire parent task.

## Tasks

- [x] 0.0 Create feature branch
  - [x] 0.1 Create and checkout a new branch: `git checkout -b feature/mobile-progress-tracking`

- [x] 1.0 Build progress domain layer (models + repository contract)
  - [x] 1.1 Create `mobile/lib/features/progress/domain/models/progress.dart` with freezed models:
    - `WorkoutHistoryEntry`: `id`, `workoutTitle`, `startedAt`, `completedAt`, `durationSeconds`, `notes`, `exerciseLogs` (list of `ExerciseLogEntry`)
    - `ExerciseLogEntry`: `exerciseName`, `setsCompleted`, `repsPerSet` (List<int>), `weightPerSet` (List<double>), `weightUnit`
    - `ProgressStats`: `totalWorkouts`, `totalDurationSeconds`, `currentStreak`, `longestStreak`, `activePrograms`
    - `PaginatedHistory`: `next` (String?), `previous` (String?), `results` (List<WorkoutHistoryEntry>) — for cursor pagination
  - [x] 1.2 Create `mobile/lib/features/progress/domain/repositories/progress_repository.dart` with abstract class:
    - `getHistory({String? cursor})` → `Future<PaginatedHistory>`
    - `getStats()` → `Future<ProgressStats>`

- [x] 2.0 Build progress data layer (data source + repository implementation)
  - [x] 2.1 Add a `getPaginated` method to `ApiClient` (`mobile/lib/core/network/api_client.dart`) that returns the full paginated response (`Map<String, dynamic>` with `next`, `previous`, `results`) instead of just the `results` list. This is needed for cursor-based pagination.
  - [x] 2.2 Create `mobile/lib/features/progress/data/datasources/progress_remote_data_source.dart`:
    - `getHistory({String? cursor})` — if cursor is null, call `ApiConfig.progressHistory`; if cursor is provided, call the cursor URL directly (it's a full URL from the backend)
    - `getStats()` — call `ApiConfig.progressStats`, return `Map<String, dynamic>`
  - [x] 2.3 Create `mobile/lib/features/progress/data/repositories/progress_repository_impl.dart`:
    - Map JSON responses to domain models (`PaginatedHistory`, `ProgressStats`)

- [x] 3.0 Build progress presentation layer (providers)
  - [x] 3.1 Create `mobile/lib/features/progress/presentation/providers/progress_provider.dart` with Riverpod providers:
    - `progressRemoteDataSource` (keepAlive) — instantiates data source with ApiClient
    - `progressRepository` (keepAlive) — instantiates repository with data source
    - `progressStats` — async provider that calls `repo.getStats()`
    - `progressHistoryNotifier` — a Notifier that manages paginated history state: holds the current list of entries, whether more pages exist, and exposes `loadInitial()` and `loadMore()` methods

- [x] 4.0 Build progress presentation widgets
  - [x] 4.1 Create `mobile/lib/features/progress/presentation/widgets/history_card.dart`:
    - Displays: date (formatted with intl), workout title, duration (e.g. "32 min"), exercise count (from `exerciseLogs.length`), total volume (computed client-side: sum of reps[i] × weight[i] for each exercise log — show "—" if all weights are 0)
    - Use Card with same styling as ProgramCard/PostCard (consistent padding, typography)
    - Card is non-tappable (summary only)
  - [x] 4.2 Create `mobile/lib/features/progress/presentation/widgets/stats_card.dart`:
    - Reusable widget that displays a label, a large number, and an icon
    - Used for: current streak (fire icon), longest streak (emoji_events icon), total workouts (fitness_center icon), total duration (timer icon)
    - Use tertiary/accent color for the icon and number to feel celebratory

- [x] 5.0 Build history and stats tab screens
  - [x] 5.1 Create `mobile/lib/features/progress/presentation/screens/history_tab.dart`:
    - Watches the history notifier provider
    - Shows loading spinner on initial load
    - Shows error state with Retry button
    - Shows empty state: "No workouts yet — start your first one!" with an icon
    - Shows ListView of HistoryCard widgets with pull-to-refresh
    - Implements infinite scroll: attach a ScrollController, when near bottom and `hasMore` is true, call `loadMore()`
  - [x] 5.2 Create `mobile/lib/features/progress/presentation/screens/stats_tab.dart`:
    - Watches the stats provider
    - Shows loading/error/empty states
    - Displays 4 StatsCard widgets in a 2×2 grid or vertical list: current streak, longest streak, total workouts, total duration (formatted as hours)

- [x] 6.0 Refactor Profile screen to use sub-tabs
  - [x] 6.1 Convert `ProfileScreen` from `ConsumerWidget` to `ConsumerStatefulWidget` (needed for `TabController` with `TickerProviderStateMixin`)
  - [x] 6.2 Add a `TabBar` below the AppBar with three tabs: "Profile", "History", "Stats"
  - [x] 6.3 Add a `TabBarView` as the body with three children:
    - Tab 0: the existing profile content (tenant branding, user info card, sign out button) extracted into its own widget
    - Tab 1: `HistoryTab` widget
    - Tab 2: `StatsTab` widget
  - [x] 6.4 Ensure the Profile tab looks identical to the current screen (no visual regressions)

- [x] 7.0 Code generation, analysis, and verification
  - [x] 7.1 Run `dart run build_runner build --delete-conflicting-outputs` to generate `.freezed.dart`, `.g.dart` files
  - [x] 7.2 Run `flutter analyze` and fix any errors or warnings (ignore pre-existing warnings in generated workout freezed code)
  - [ ] 7.3 Verify the app builds and runs: Profile tab shows 3 sub-tabs, History loads from API, Stats display correctly, infinite scroll works on History
