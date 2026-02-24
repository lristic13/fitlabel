import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fitlabel/features/workouts/domain/models/workout_session.dart';

class ExerciseSetRow extends StatefulWidget {
  final int setIndex;
  final SetLog setLog;
  final int targetReps;
  final void Function(int reps, double weight) onComplete;
  final VoidCallback onUncomplete;

  const ExerciseSetRow({
    super.key,
    required this.setIndex,
    required this.setLog,
    required this.targetReps,
    required this.onComplete,
    required this.onUncomplete,
  });

  @override
  State<ExerciseSetRow> createState() => _ExerciseSetRowState();
}

class _ExerciseSetRowState extends State<ExerciseSetRow> {
  late final TextEditingController _repsController;
  late final TextEditingController _weightController;
  bool _repsError = false;

  @override
  void initState() {
    super.initState();
    _repsController = TextEditingController(
      text: widget.setLog.reps > 0 ? '${widget.setLog.reps}' : '',
    );
    _weightController = TextEditingController(
      text: widget.setLog.weight > 0
          ? widget.setLog.weight.toStringAsFixed(
              widget.setLog.weight.truncateToDouble() == widget.setLog.weight
                  ? 0
                  : 1,
            )
          : '',
    );
  }

  @override
  void dispose() {
    _repsController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _handleComplete() {
    final reps = int.tryParse(_repsController.text) ?? 0;
    if (reps <= 0) {
      // Shake the reps field by briefly showing error state
      setState(() => _repsError = true);
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) setState(() => _repsError = false);
      });
      return;
    }
    final weight = double.tryParse(_weightController.text) ?? 0;
    widget.onComplete(reps, weight);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCompleted = widget.setLog.completed;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(
              'Set ${widget.setIndex + 1}',
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: isCompleted
                    ? theme.colorScheme.tertiary
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 60,
            height: 38,
            child: TextField(
              controller: _repsController,
              enabled: !isCompleted,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall,
              decoration: InputDecoration(
                hintText: 'reps',
                hintStyle: theme.textTheme.bodySmall?.copyWith(
                  color: _repsError
                      ? theme.colorScheme.error
                      : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 8),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: _repsError
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: theme.colorScheme.error),
                      )
                    : null,
                filled: true,
                fillColor: isCompleted
                    ? theme.colorScheme.surfaceContainerHighest
                    : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text('x',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                )),
          ),
          SizedBox(
            width: 68,
            height: 38,
            child: TextField(
              controller: _weightController,
              enabled: !isCompleted,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
              ],
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall,
              decoration: InputDecoration(
                hintText: 'kg',
                hintStyle: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 8),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: isCompleted
                    ? theme.colorScheme.surfaceContainerHighest
                    : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 38,
            height: 38,
            child: IconButton.filled(
              onPressed: isCompleted
                  ? widget.onUncomplete
                  : _handleComplete,
              icon: Icon(
                isCompleted ? Icons.check : Icons.check_outlined,
                size: 18,
              ),
              style: IconButton.styleFrom(
                backgroundColor: isCompleted
                    ? theme.colorScheme.tertiary
                    : theme.colorScheme.surfaceContainerHighest,
                foregroundColor: isCompleted
                    ? theme.colorScheme.onTertiary
                    : theme.colorScheme.onSurfaceVariant,
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
