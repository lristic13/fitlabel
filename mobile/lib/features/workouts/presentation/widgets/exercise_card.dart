import 'package:flutter/material.dart';

import 'package:fitlabel/features/workouts/domain/models/workout.dart';

class ExerciseCard extends StatelessWidget {
  final ExerciseEntry entry;
  final int index;

  const ExerciseCard({
    super.key,
    required this.entry,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final exercise = entry.exercise;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
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
                  ),
                  const SizedBox(height: 4),
                  ExerciseCardSetsReps(entry: entry),
                  if (exercise.muscleGroups.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    ExerciseCardMuscleGroups(
                      muscleGroups: exercise.muscleGroups,
                    ),
                  ],
                  if (entry.notes != null && entry.notes!.isNotEmpty) ...[
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
          ],
        ),
      ),
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
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          demoImage.thumbnail as String,
          width: 64,
          height: 64,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => ExerciseCardThumbnailPlaceholder(),
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
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
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

  const ExerciseCardTitle({
    super.key,
    required this.name,
    this.supersetGroup,
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
      spacing: 4,
      runSpacing: 4,
      children: muscleGroups.map((group) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(4),
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
