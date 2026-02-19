import 'package:flutter/material.dart';

import 'package:fitlabel/features/programs/domain/models/program.dart';

class ProgramHeader extends StatelessWidget {
  final ProgramDetail program;

  const ProgramHeader({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          program.title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Chip(label: Text(program.difficulty)),
            const SizedBox(width: 8),
            Chip(label: Text('${program.durationWeeks} weeks')),
            if (!program.isFree) ...[
              const SizedBox(width: 8),
              Chip(
                label: const Text('Premium'),
                backgroundColor: theme.colorScheme.tertiaryContainer,
              ),
            ],
          ],
        ),
        if (program.description.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            program.description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}
