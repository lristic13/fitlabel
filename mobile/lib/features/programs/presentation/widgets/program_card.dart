import 'package:flutter/material.dart';

import 'package:fitlabel/features/programs/domain/models/program.dart';

class ProgramCard extends StatelessWidget {
  final Program program;
  final VoidCallback onTap;

  const ProgramCard({
    super.key,
    required this.program,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProgramCardImage(coverImage: program.coverImage),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    program.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  ProgramCardMeta(program: program),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProgramCardImage extends StatelessWidget {
  final dynamic coverImage;

  const ProgramCardImage({super.key, required this.coverImage});

  @override
  Widget build(BuildContext context) {
    if (coverImage?.file != null) {
      return Image.network(
        coverImage.file as String,
        height: 160,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => const ProgramCardImagePlaceholder(),
      );
    }
    return const ProgramCardImagePlaceholder();
  }
}

class ProgramCardImagePlaceholder extends StatelessWidget {
  const ProgramCardImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Icon(
        Icons.fitness_center,
        size: 48,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    );
  }
}

class ProgramCardMeta extends StatelessWidget {
  final Program program;

  const ProgramCardMeta({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final metaStyle = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    return Row(
      children: [
        Icon(Icons.signal_cellular_alt,
            size: 14, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 4),
        Text(program.difficulty, style: metaStyle),
        const SizedBox(width: 12),
        Icon(Icons.calendar_today,
            size: 14, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 4),
        Text('${program.durationWeeks} weeks', style: metaStyle),
        const Spacer(),
        if (!program.isFree)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: theme.colorScheme.tertiary,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'PREMIUM',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onTertiary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
