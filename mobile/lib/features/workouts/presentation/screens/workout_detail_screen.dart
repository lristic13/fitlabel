import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fitlabel/features/workouts/domain/models/workout.dart';
import 'package:fitlabel/features/workouts/domain/models/workout_session.dart';
import 'package:fitlabel/features/workouts/presentation/providers/workouts_provider.dart';
import 'package:fitlabel/features/workouts/presentation/providers/workout_session_provider.dart';
import 'package:fitlabel/features/workouts/presentation/widgets/exercise_card.dart';
import 'package:fitlabel/features/workouts/presentation/widgets/workout_action_bar.dart';

class WorkoutDetailScreen extends ConsumerStatefulWidget {
  final String workoutId;
  final String? programDayId;

  const WorkoutDetailScreen({
    super.key,
    required this.workoutId,
    this.programDayId,
  });

  @override
  ConsumerState<WorkoutDetailScreen> createState() =>
      _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends ConsumerState<WorkoutDetailScreen> {
  bool _logLoaded = false;

  @override
  Widget build(BuildContext context) {
    final workoutId = widget.workoutId;
    final programDayId = widget.programDayId;
    final detailState =
        ref.watch(workoutDetailProvider((workoutId, programDayId)));
    final sessionState =
        ref.watch(workoutSessionNotifierProvider(workoutId));

    // Auto-populate session from previously completed log
    if (!_logLoaded && sessionState.valueOrNull == null) {
      final detail = detailState.valueOrNull;
      if (detail != null &&
          detail.latestLog != null &&
          detail.latestLog!.completedAt != null) {
        _logLoaded = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            ref
                .read(workoutSessionNotifierProvider(workoutId).notifier)
                .loadFromLog(detail.latestLog!, detail.exerciseEntries);
          }
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: detailState.whenOrNull(
          data: (workout) => Text(workout.title),
        ),
      ),
      body: detailState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Failed to load workout',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              FilledButton.tonal(
                onPressed: () => ref
                    .invalidate(workoutDetailProvider((workoutId, programDayId))),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (workout) => WorkoutDetailBody(
          workout: workout,
          session: sessionState.valueOrNull,
          workoutId: workoutId,
        ),
      ),
      bottomNavigationBar: detailState.hasValue
          ? WorkoutBottomBar(
              workoutId: workoutId,
              programDayId: programDayId,
              sessionState: sessionState,
              exerciseEntries: detailState.valueOrNull?.exerciseEntries,
              latestLog: detailState.valueOrNull?.latestLog,
            )
          : null,
    );
  }
}

class WorkoutBottomBar extends ConsumerWidget {
  final String workoutId;
  final String? programDayId;
  final AsyncValue<WorkoutSession?> sessionState;
  final List<ExerciseEntry>? exerciseEntries;
  final WorkoutLog? latestLog;

  const WorkoutBottomBar({
    super.key,
    required this.workoutId,
    this.programDayId,
    required this.sessionState,
    required this.exerciseEntries,
    this.latestLog,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = sessionState is AsyncLoading;
    final session = sessionState.valueOrNull;

    // Active session completed
    if (session != null && session.workoutLog.completedAt != null) {
      return WorkoutCompletedBar(
        durationSeconds: session.workoutLog.durationSeconds,
        onDone: () => context.pop(true),
      );
    }

    // Active session in progress — show progress
    if (session != null) {
      return WorkoutActiveBar(
        session: session,
        onFinishEarly: () => ref
            .read(workoutSessionNotifierProvider(workoutId).notifier)
            .finishEarly(),
      );
    }

    // Previously completed (from backend) — show completed state
    if (latestLog != null && latestLog!.completedAt != null) {
      return WorkoutCompletedBar(
        durationSeconds: latestLog!.durationSeconds,
        onDone: () => context.pop(true),
      );
    }

    // No session — show start button
    return WorkoutStartBar(
      isLoading: isLoading,
      onStart: () {
        if (exerciseEntries != null) {
          ref
              .read(workoutSessionNotifierProvider(workoutId).notifier)
              .start(exerciseEntries!, programDayId: programDayId);
        }
      },
    );
  }
}

class WorkoutDetailBody extends ConsumerWidget {
  final WorkoutDetail workout;
  final WorkoutSession? session;
  final String workoutId;

  const WorkoutDetailBody({
    super.key,
    required this.workout,
    required this.session,
    required this.workoutId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        WorkoutDetailHeader(workout: workout),
        const SizedBox(height: 16),
        Text(
          'Exercises',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...List.generate(
          workout.exerciseEntries.length,
          (index) {
            final entry = workout.exerciseEntries[index];
            final exerciseLog = session?.exerciseLogs[entry.exercise.id];

            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ExerciseCard(
                entry: entry,
                index: index,
                sessionLog: exerciseLog,
                onSetComplete: exerciseLog != null
                    ? (setIndex, reps, weight) {
                        ref
                            .read(workoutSessionNotifierProvider(workoutId)
                                .notifier)
                            .updateSet(
                                entry.exercise.id, setIndex, reps, weight);
                        ref
                            .read(workoutSessionNotifierProvider(workoutId)
                                .notifier)
                            .toggleSet(entry.exercise.id, setIndex);
                      }
                    : null,
                onSetUncomplete: exerciseLog != null
                    ? (setIndex) {
                        ref
                            .read(workoutSessionNotifierProvider(workoutId)
                                .notifier)
                            .toggleSet(entry.exercise.id, setIndex);
                      }
                    : null,
              ),
            );
          },
        ),
        // Extra padding at bottom so content isn't hidden by bottom bar
        const SizedBox(height: 80),
      ],
    );
  }
}

class WorkoutDetailHeader extends StatelessWidget {
  final WorkoutDetail workout;

  const WorkoutDetailHeader({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          workout.title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        if (workout.description != null &&
            workout.description!.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            workout.description!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
        const SizedBox(height: 8),
        Row(
          children: [
            if (workout.estimatedDurationMinutes != null) ...[
              Icon(Icons.timer_outlined,
                  size: 16, color: theme.colorScheme.onSurfaceVariant),
              const SizedBox(width: 4),
              Text(
                '${workout.estimatedDurationMinutes} min',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 16),
            ],
            Icon(Icons.fitness_center,
                size: 16, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(width: 4),
            Text(
              '${workout.exerciseEntries.length} exercises',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
