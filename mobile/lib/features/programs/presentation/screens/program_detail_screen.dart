import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fitlabel/features/programs/domain/models/program.dart';
import 'package:fitlabel/features/programs/presentation/providers/programs_provider.dart';
import 'package:fitlabel/features/programs/presentation/widgets/program_header.dart';
import 'package:fitlabel/features/programs/presentation/widgets/program_week_card.dart';

class ProgramDetailScreen extends ConsumerWidget {
  final String programId;

  const ProgramDetailScreen({super.key, required this.programId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(programDetailProvider(programId));

    return Scaffold(
      appBar: AppBar(
        title: detailState.whenOrNull(
          data: (program) => Text(program.title),
        ),
      ),
      body: detailState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Failed to load program',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              FilledButton.tonal(
                onPressed: () =>
                    ref.invalidate(programDetailProvider(programId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (program) => ProgramDetailBody(
          program: program,
          onDayTap: (day) async {
            if (day.workoutId != null) {
              final completed = await context.push<bool>(
                Uri(
                  path: '/workouts/${day.workoutId}',
                  queryParameters: {'programDayId': '${day.id}'},
                ).toString(),
              );
              if (completed == true) {
                ref.invalidate(programDetailProvider(programId));
              }
            }
          },
        ),
      ),
    );
  }
}

class ProgramDetailBody extends StatelessWidget {
  final ProgramDetail program;
  final void Function(ProgramDay day) onDayTap;

  const ProgramDetailBody({
    super.key,
    required this.program,
    required this.onDayTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ProgramHeader(program: program),
        const SizedBox(height: 16),
        ...program.weeks.map(
          (week) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ProgramWeekCard(
              week: week,
              completedDayIds: program.completedDayIds.toSet(),
              onDayTap: onDayTap,
            ),
          ),
        ),
      ],
    );
  }
}
