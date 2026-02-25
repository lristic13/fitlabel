import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fitlabel/features/progress/presentation/providers/progress_provider.dart';
import 'package:fitlabel/features/progress/presentation/widgets/stats_card.dart';

class StatsTab extends ConsumerWidget {
  const StatsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsState = ref.watch(progressStatsProvider);

    return statsState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 16),
            Text('Failed to load stats',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            FilledButton.tonal(
              onPressed: () => ref.invalidate(progressStatsProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (stats) {
        final totalHours = stats.totalDurationSeconds ~/ 3600;
        final totalMinutes = (stats.totalDurationSeconds % 3600) ~/ 60;
        final durationLabel =
            totalHours > 0 ? '$totalHours h $totalMinutes min' : '$totalMinutes min';

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: StatsCard(
                      icon: Icons.local_fire_department,
                      value: '${stats.currentStreak}',
                      label: 'Current Streak',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StatsCard(
                      icon: Icons.emoji_events,
                      value: '${stats.longestStreak}',
                      label: 'Longest Streak',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: StatsCard(
                      icon: Icons.fitness_center,
                      value: '${stats.totalWorkouts}',
                      label: 'Total Workouts',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StatsCard(
                      icon: Icons.timer,
                      value: durationLabel,
                      label: 'Total Time',
                    ),
                  ),
                ],
              ),
              if (stats.activePrograms > 0) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: StatsCard(
                        icon: Icons.calendar_today,
                        value: '${stats.activePrograms}',
                        label: 'Active Programs',
                      ),
                    ),
                    const Expanded(child: SizedBox.shrink()),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
