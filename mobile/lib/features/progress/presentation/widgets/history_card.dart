import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:fitlabel/features/progress/domain/models/progress.dart';

class HistoryCard extends StatelessWidget {
  final WorkoutHistoryEntry entry;

  const HistoryCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final metaStyle = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry.workoutTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 6,
              children: [
                _MetaChip(
                  icon: Icons.calendar_today,
                  label: DateFormat.yMMMd().format(entry.completedAt ?? entry.startedAt),
                  style: metaStyle,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                if (entry.durationSeconds != null)
                  _MetaChip(
                    icon: Icons.timer_outlined,
                    label: '${entry.durationSeconds! ~/ 60} min',
                    style: metaStyle,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                _MetaChip(
                  icon: Icons.fitness_center,
                  label: '${entry.exerciseLogs.length} exercises',
                  style: metaStyle,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                _MetaChip(
                  icon: Icons.monitor_weight_outlined,
                  label: _totalVolume(),
                  style: metaStyle,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _totalVolume() {
    double total = 0;
    for (final log in entry.exerciseLogs) {
      for (int i = 0; i < log.repsPerSet.length; i++) {
        final weight = i < log.weightPerSet.length ? log.weightPerSet[i] : 0.0;
        total += log.repsPerSet[i] * weight;
      }
    }
    if (total == 0) return '\u2014';
    final unit =
        entry.exerciseLogs.isNotEmpty ? entry.exerciseLogs.first.weightUnit : 'KG';
    return '${NumberFormat('#,##0').format(total.round())} ${unit.toLowerCase()}';
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextStyle? style;
  final Color color;

  const _MetaChip({
    required this.icon,
    required this.label,
    required this.style,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(label, style: style),
      ],
    );
  }
}
