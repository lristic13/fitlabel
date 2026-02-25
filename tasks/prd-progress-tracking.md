# PRD: Progress Tracking & Workout History

## 1. Introduction / Overview

Users currently complete workouts but have no way to look back at what they've done. The progress tracking feature adds **workout history** and **streak stats** to the Profile tab, organized as sub-tabs. This gives users a sense of accomplishment and continuity — they can see every past workout with rich detail and track their consistency through current and longest workout streaks.

## 2. Goals

- Let users view their complete workout history with meaningful summary data per entry.
- Show workout streak stats (current streak and longest streak) to drive consistency.
- Integrate seamlessly into the existing Profile tab using sub-tabs (Profile / History / Stats).
- Consume the existing backend endpoints (`/v1/progress/history/` and `/v1/progress/stats/`).

## 3. User Stories

- **As a user**, I want to see a list of all my completed workouts so I can track what I've done over time.
- **As a user**, I want each history entry to show the date, workout name, duration, exercise count, total volume, and muscle groups hit so I can quickly recall the session.
- **As a user**, I want to see my current workout streak (consecutive days with a completed workout) so I stay motivated.
- **As a user**, I want to see my longest-ever streak so I have a goal to beat.
- **As a user**, I want to switch between my profile info, workout history, and stats using sub-tabs without leaving the Profile screen.

## 4. Functional Requirements

### 4.1 Profile Sub-Tabs

1. The existing Profile screen is restructured into three sub-tabs: **Profile**, **History**, and **Stats**.
2. Sub-tabs are displayed below the app bar using a `TabBar` (or equivalent segmented control).
3. The **Profile** sub-tab contains everything currently shown on the Profile screen (no changes to existing content).
4. The default selected sub-tab is **Profile**.

### 4.2 History Sub-Tab

5. Displays a reverse-chronological list of completed workouts fetched from `GET /v1/progress/history/`.
6. Each history entry (card/tile) displays:
   - **Date** of the workout (formatted, e.g. "Feb 24, 2026")
   - **Workout name** (title)
   - **Duration** (e.g. "32 min")
   - **Exercise count** (e.g. "5 exercises")
   - **Total volume** (sum of sets × reps × weight across all exercises, e.g. "4,200 kg") — display "—" if no weight data
   - **Muscle groups** hit (shown as small chips/tags)
7. The list supports **pull-to-refresh**.
8. Loading, error, and empty states are handled:
   - **Loading**: centered spinner.
   - **Error**: error message with a Retry button.
   - **Empty**: friendly message like "No workouts yet — start your first one!"
9. History entries are **summary-only** — tapping a card does nothing (no detail navigation).
10. The list is paginated if the backend supports it (cursor-based), with infinite scroll loading more entries.

### 4.3 Stats Sub-Tab

11. Displays workout streak information fetched from `GET /v1/progress/stats/`.
12. **Current streak**: the number of consecutive days (up to today) the user completed at least one workout. Displayed prominently with a flame/fire icon.
13. **Longest streak**: the user's all-time best streak. Displayed alongside the current streak for comparison.
14. **Total workouts**: the total count of completed workouts.
15. Stats are displayed as large, prominent cards or tiles — easy to read at a glance.
16. Loading, error, and empty states are handled (same pattern as History).

## 5. Non-Goals (Out of Scope)

- **Workout detail view from history**: tapping a past workout does NOT open a detail screen. Summary only.
- **Charts/graphs**: no line charts, bar charts, or visual graphs. Streak and stats are shown as numbers/cards.
- **Volume progression over time**: not tracked as a trend — only shown per individual workout in history.
- **Program progress tracking**: this PRD covers workout-level history only, not program enrollment progress.
- **Editing or deleting past workout logs**.
- **Sharing or exporting workout history**.

## 6. Design Considerations

- Sub-tabs should use Material 3 `TabBar` with the app's theme colors, consistent with the rest of the app.
- History cards should follow the same card style used in Programs and Posts (consistent elevation, padding, typography).
- Streak stats should feel celebratory — use the tertiary/accent color for the fire icon and streak numbers.
- Muscle group chips in history cards should match the style used in exercise cards (`ExerciseCardMuscleGroups`).
- Keep the Profile sub-tab identical to the current Profile screen — no visual regressions.

## 7. Technical Considerations

- **API endpoints**: `ApiConfig.progressHistory` and `ApiConfig.progressStats` are already defined in `api_config.dart`.
- **Architecture**: follow the same clean architecture pattern as Programs/Posts — domain models (freezed), repository, data source, Riverpod providers, presentation widgets.
- **New files** should go under `lib/features/progress/` following the feature-first structure.
- **Profile screen refactor**: the existing `lib/features/profile/presentation/screens/profile_screen.dart` needs to be updated to wrap its content in a `TabBarView` with the three sub-tabs. The current profile content becomes the first tab's body.
- Total volume per workout log must be computed client-side from the exercise log data (sum of `reps × weight` per set, across all exercises).
- **Muscle groups** are NOT included in the history API response. The exercise logs only contain `exercise_name`, not muscle groups. Either omit muscle groups from history cards or fetch them separately (recommend omitting for MVP to keep it simple).

### Backend API Response Shapes (verified)

**`GET /v1/progress/history/`** — Cursor-paginated (page size 20, ordered by `-created_at`)

```json
{
  "next": "http://...?cursor=abc123",
  "previous": null,
  "results": [
    {
      "id": "uuid",
      "workout_title": "Morning Flow",
      "started_at": "2026-02-24T08:00:00Z",
      "completed_at": "2026-02-24T08:32:00Z",
      "duration_seconds": 1920,
      "notes": "",
      "exercise_logs": [
        {
          "exercise_name": "Barbell Squat",
          "sets_completed": 3,
          "reps_per_set": [12, 10, 8],
          "weight_per_set": [60.0, 65.0, 70.0],
          "weight_unit": "KG"
        }
      ]
    }
  ]
}
```

**`GET /v1/progress/stats/`** — Single object (not paginated)

```json
{
  "total_workouts": 42,
  "total_duration_seconds": 75600,
  "current_streak": 5,
  "longest_streak": 12,
  "active_programs": 2
}
```

### Pagination

The history endpoint uses DRF's **CursorPagination** (page size 20). The mobile app should implement infinite scroll — when the user scrolls near the bottom, fetch the `next` cursor URL to load more entries.

### Streak Logic

Streaks are calculated server-side from distinct `completed_at` dates (calendar days). Current streak resets to 0 if the last workout was more than 1 day ago. All streak computation happens on the backend — no client-side calculation needed.

## 8. Success Metrics

- Users can view their full workout history with all summary fields populated.
- Current streak and longest streak display correctly and update after completing a new workout.
- Sub-tab navigation works smoothly with no visual regressions to the existing Profile screen.
- All three states (loading, error, empty) are handled gracefully on both History and Stats tabs.

## 9. Open Questions

All previously open questions have been resolved:

1. ~~Response shapes~~ — **Resolved.** See Section 7 for exact JSON shapes.
2. ~~Pagination~~ — **Resolved.** Cursor-based, page size 20, ordered by `-created_at`.
3. ~~Streak calculation~~ — **Resolved.** Calendar days, computed server-side.
4. ~~Stats fields~~ — **Resolved.** Backend returns `total_workouts`, `total_duration_seconds`, `current_streak`, `longest_streak`, `active_programs`. No client-side computation needed for stats.
5. **Muscle groups in history cards** — The backend history response does NOT include muscle groups per exercise. Recommend dropping muscle groups from the history card design and showing exercise count instead (derivable from `exercise_logs.length`). Alternatively, we could add muscle groups to the backend serializer, but that increases scope.
