import 'package:flutter/material.dart';

import 'package:fitlabel/features/workouts/domain/models/workout.dart';

class WorkoutCard extends StatelessWidget {
  final WorkoutBrief workout;
  final VoidCallback onTap;

  const WorkoutCard({super.key, required this.workout, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              WorkoutCardThumbnail(coverImage: workout.coverImage),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workout.title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    WorkoutCardMeta(workout: workout),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

class WorkoutCardThumbnail extends StatelessWidget {
  final dynamic coverImage;

  const WorkoutCardThumbnail({super.key, required this.coverImage});

  @override
  Widget build(BuildContext context) {
    if (coverImage?.thumbnail != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          coverImage.thumbnail as String,
          width: 56,
          height: 56,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) =>
              const WorkoutCardThumbnailPlaceholder(),
        ),
      );
    }
    return const WorkoutCardThumbnailPlaceholder();
  }
}

class WorkoutCardThumbnailPlaceholder extends StatelessWidget {
  const WorkoutCardThumbnailPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
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

class WorkoutCardMeta extends StatelessWidget {
  final WorkoutBrief workout;

  const WorkoutCardMeta({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final metaStyle = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    return Row(
      children: [
        Icon(Icons.fitness_center,
            size: 14, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 4),
        Text('${workout.exerciseCount} exercises', style: metaStyle),
        if (workout.estimatedDurationMinutes != null) ...[
          const SizedBox(width: 12),
          Icon(Icons.timer_outlined,
              size: 14, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 4),
          Text('${workout.estimatedDurationMinutes} min', style: metaStyle),
        ],
      ],
    );
  }
}
