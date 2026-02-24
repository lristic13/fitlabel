import 'package:flutter/material.dart';

import 'package:fitlabel/features/workouts/domain/models/workout_session.dart';

class WorkoutStartBar extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onStart;

  const WorkoutStartBar({
    super.key,
    required this.isLoading,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: FilledButton.icon(
            onPressed: isLoading ? null : onStart,
            icon: isLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  )
                : const Icon(Icons.play_arrow),
            label: const Text('Start Workout'),
          ),
        ),
      ),
    );
  }
}

class WorkoutActiveBar extends StatelessWidget {
  final WorkoutSession session;
  final VoidCallback onFinishEarly;

  const WorkoutActiveBar({
    super.key,
    required this.session,
    required this.onFinishEarly,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final completed = session.completedExerciseCount;
    final total = session.totalExerciseCount;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            WorkoutTimer(startedAt: session.workoutLog.startedAt),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: session.progressFraction,
                      minHeight: 8,
                      backgroundColor:
                          theme.colorScheme.surfaceContainerHighest,
                      color: theme.colorScheme.tertiary,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '$completed/$total exercises',
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: TextButton(
                onPressed: onFinishEarly,
                child: const Text('Finish Early'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WorkoutTimer extends StatefulWidget {
  final DateTime startedAt;

  const WorkoutTimer({super.key, required this.startedAt});

  @override
  State<WorkoutTimer> createState() => _WorkoutTimerState();
}

class _WorkoutTimerState extends State<WorkoutTimer> {
  late final Stream<int> _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Stream.periodic(
      const Duration(seconds: 1),
      (_) => DateTime.now().difference(widget.startedAt).inSeconds,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StreamBuilder<int>(
      stream: _ticker,
      builder: (context, snapshot) {
        final seconds = snapshot.data ?? 0;
        final minutes = seconds ~/ 60;
        final secs = seconds % 60;
        final display =
            '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.timer,
                size: 20, color: theme.colorScheme.tertiary),
            const SizedBox(width: 8),
            Text(
              display,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontFeatures: [const FontFeature.tabularFigures()],
              ),
            ),
          ],
        );
      },
    );
  }
}

class WorkoutCompletedBar extends StatelessWidget {
  final int? durationSeconds;
  final VoidCallback onDone;

  const WorkoutCompletedBar({
    super.key,
    required this.durationSeconds,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final minutes = (durationSeconds ?? 0) ~/ 60;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle,
                    color: theme.colorScheme.tertiary, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Completed in $minutes min',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.tertiary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton(
                onPressed: onDone,
                child: const Text('Done'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
