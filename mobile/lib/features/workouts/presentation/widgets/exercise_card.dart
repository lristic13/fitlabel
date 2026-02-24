import 'package:flutter/material.dart';

import 'package:fitlabel/features/workouts/domain/models/workout.dart';
import 'package:fitlabel/features/workouts/domain/models/workout_session.dart';
import 'package:fitlabel/features/workouts/presentation/widgets/exercise_set_row.dart';

class ExerciseCard extends StatelessWidget {
  final ExerciseEntry entry;
  final int index;
  final ExerciseSessionLog? sessionLog;
  final void Function(int setIndex, int reps, double weight)? onSetComplete;
  final void Function(int setIndex)? onSetUncomplete;

  const ExerciseCard({
    super.key,
    required this.entry,
    required this.index,
    this.sessionLog,
    this.onSetComplete,
    this.onSetUncomplete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final exercise = entry.exercise;
    final isExerciseComplete = sessionLog?.isComplete ?? false;

    return Card(
      color: isExerciseComplete
          ? theme.colorScheme.tertiaryContainer.withValues(alpha: 0.3)
          : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExerciseCardThumbnail(demoImage: exercise.demoImage),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExerciseCardTitle(
                        name: exercise.name,
                        supersetGroup: entry.supersetGroup,
                        isComplete: isExerciseComplete,
                      ),
                      const SizedBox(height: 4),
                      ExerciseCardSetsReps(entry: entry),
                      if (exercise.muscleGroups.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        ExerciseCardMuscleGroups(
                          muscleGroups: exercise.muscleGroups,
                        ),
                      ],
                      if (entry.notes != null &&
                          entry.notes!.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(
                          entry.notes!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (isExerciseComplete)
                  Icon(Icons.check_circle,
                      color: theme.colorScheme.tertiary, size: 24),
              ],
            ),
            // Set logging rows when session is active
            if (sessionLog != null) ...[
              const Divider(height: 16),
              ExerciseSetLogging(
                entry: entry,
                sessionLog: sessionLog!,
                onSetComplete: onSetComplete!,
                onSetUncomplete: onSetUncomplete!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ExerciseSetLogging extends StatelessWidget {
  final ExerciseEntry entry;
  final ExerciseSessionLog sessionLog;
  final void Function(int setIndex, int reps, double weight) onSetComplete;
  final void Function(int setIndex) onSetUncomplete;

  const ExerciseSetLogging({
    super.key,
    required this.entry,
    required this.sessionLog,
    required this.onSetComplete,
    required this.onSetUncomplete,
  });

  int _parseTargetReps(String reps) {
    final parsed = int.tryParse(reps);
    if (parsed != null) return parsed;
    if (reps.contains('-')) {
      final upper = int.tryParse(reps.split('-').last.trim());
      if (upper != null) return upper;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final targetReps = _parseTargetReps(entry.reps);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '${sessionLog.completedSetsCount}/${sessionLog.targetSets} sets',
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: sessionLog.isComplete
                    ? theme.colorScheme.tertiary
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: LinearProgressIndicator(
                value: sessionLog.targetSets > 0
                    ? sessionLog.completedSetsCount / sessionLog.targetSets
                    : 0,
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                color: theme.colorScheme.tertiary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...List.generate(
          sessionLog.sets.length,
          (i) => ExerciseSetRow(
            setIndex: i,
            setLog: sessionLog.sets[i],
            targetReps: targetReps,
            onComplete: (reps, weight) => onSetComplete(i, reps, weight),
            onUncomplete: () => onSetUncomplete(i),
          ),
        ),
      ],
    );
  }
}

class ExerciseCardThumbnail extends StatelessWidget {
  final dynamic demoImage;

  const ExerciseCardThumbnail({super.key, required this.demoImage});

  @override
  Widget build(BuildContext context) {
    if (demoImage?.thumbnail != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          demoImage.thumbnail as String,
          width: 72,
          height: 72,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) =>
              const ExerciseCardThumbnailPlaceholder(),
        ),
      );
    }

    return const ExerciseCardThumbnailPlaceholder();
  }
}

class ExerciseCardThumbnailPlaceholder extends StatelessWidget {
  const ExerciseCardThumbnailPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        Icons.fitness_center,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}

class ExerciseCardTitle extends StatelessWidget {
  final String name;
  final int? supersetGroup;
  final bool isComplete;

  const ExerciseCardTitle({
    super.key,
    required this.name,
    this.supersetGroup,
    this.isComplete = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        if (supersetGroup != null) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: theme.colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'SS$supersetGroup',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSecondaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 6),
        ],
        Expanded(
          child: Text(
            name,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: isComplete ? theme.colorScheme.tertiary : null,
            ),
          ),
        ),
      ],
    );
  }
}

class ExerciseCardSetsReps extends StatelessWidget {
  final ExerciseEntry entry;

  const ExerciseCardSetsReps({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final metaStyle = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    return Row(
      children: [
        Text('${entry.sets} sets', style: metaStyle),
        const SizedBox(width: 4),
        Text('x', style: metaStyle),
        const SizedBox(width: 4),
        Text('${entry.reps} reps', style: metaStyle),
        const SizedBox(width: 12),
        Icon(Icons.timer_outlined,
            size: 14, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 2),
        Text('${entry.restSeconds}s rest', style: metaStyle),
      ],
    );
  }
}

class ExerciseCardMuscleGroups extends StatelessWidget {
  final List<String> muscleGroups;

  const ExerciseCardMuscleGroups({super.key, required this.muscleGroups});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: muscleGroups.map((group) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: ShapeDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            shape: const StadiumBorder(),
          ),
          child: Text(
            group,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        );
      }).toList(),
    );
  }
}
