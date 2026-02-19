import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fitlabel/features/workouts/presentation/providers/workouts_provider.dart';
import 'package:fitlabel/features/workouts/presentation/widgets/exercise_card.dart';
import 'package:fitlabel/features/workouts/domain/models/workout.dart';

class WorkoutDetailScreen extends ConsumerWidget {
  final String workoutId;

  const WorkoutDetailScreen({super.key, required this.workoutId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(workoutDetailProvider(workoutId));

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
                onPressed: () =>
                    ref.invalidate(workoutDetailProvider(workoutId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (workout) => WorkoutDetailBody(workout: workout),
      ),
    );
  }
}

class WorkoutDetailBody extends StatelessWidget {
  final WorkoutDetail workout;

  const WorkoutDetailBody({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
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
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ExerciseCard(
              entry: workout.exerciseEntries[index],
              index: index,
            ),
          ),
        ),
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
