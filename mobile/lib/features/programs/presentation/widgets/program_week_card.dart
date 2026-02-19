import 'package:flutter/material.dart';

import 'package:fitlabel/features/programs/domain/models/program.dart';

class ProgramWeekCard extends StatelessWidget {
  final ProgramWeek week;
  final void Function(ProgramDay day) onDayTap;

  const ProgramWeekCard({
    super.key,
    required this.week,
    required this.onDayTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              week.title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...week.days.map(
              (day) => ProgramDayTile(day: day, onTap: () => onDayTap(day)),
            ),
          ],
        ),
      ),
    );
  }
}

class ProgramDayTile extends StatelessWidget {
  final ProgramDay day;
  final VoidCallback onTap;

  const ProgramDayTile({super.key, required this.day, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isRest = day.isRestDay;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 16,
        backgroundColor: isRest
            ? theme.colorScheme.surfaceContainerHighest
            : theme.colorScheme.primaryContainer,
        child: Text(
          '${day.dayNumber}',
          style: theme.textTheme.labelMedium?.copyWith(
            color: isRest
                ? theme.colorScheme.onSurfaceVariant
                : theme.colorScheme.onPrimaryContainer,
          ),
        ),
      ),
      title: Text(
        day.title,
        style: TextStyle(
          color: isRest ? theme.colorScheme.onSurfaceVariant : null,
          fontStyle: isRest ? FontStyle.italic : null,
        ),
      ),
      subtitle: isRest
          ? null
          : day.workoutTitle != null
              ? Text(day.workoutTitle!)
              : null,
      trailing: isRest ? null : const Icon(Icons.chevron_right),
      enabled: !isRest && day.workoutId != null,
      onTap: isRest || day.workoutId == null ? null : onTap,
    );
  }
}
