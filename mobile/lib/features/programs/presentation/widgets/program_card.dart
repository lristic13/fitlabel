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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    program.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
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
        height: 180,
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
    final primary = Theme.of(context).colorScheme.primary;

    return Container(
      height: 180,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primary.withValues(alpha: 0.8),
            primary.withValues(alpha: 0.4),
          ],
        ),
      ),
      child: const Icon(
        Icons.fitness_center,
        size: 48,
        color: Colors.white54,
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: ShapeDecoration(
              color: theme.colorScheme.tertiary,
              shape: const StadiumBorder(),
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
