import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fitlabel/features/workouts/data/datasources/workouts_remote_data_source.dart';
import 'package:fitlabel/features/workouts/data/repositories/workouts_repository_impl.dart';
import 'package:fitlabel/features/workouts/domain/models/workout.dart';
import 'package:fitlabel/features/workouts/domain/repositories/workouts_repository.dart';
import 'package:fitlabel/shared/providers/core_providers.dart';

part 'workouts_provider.g.dart';

@Riverpod(keepAlive: true)
WorkoutsRemoteDataSource workoutsRemoteDataSource(Ref ref) {
  final client = ref.watch(apiClientProvider);
  return WorkoutsRemoteDataSource(client: client);
}

@Riverpod(keepAlive: true)
WorkoutsRepository workoutsRepository(Ref ref) {
  final dataSource = ref.watch(workoutsRemoteDataSourceProvider);
  return WorkoutsRepositoryImpl(dataSource: dataSource);
}

@riverpod
Future<List<WorkoutBrief>> workoutsList(Ref ref) {
  final repo = ref.watch(workoutsRepositoryProvider);
  return repo.getWorkouts();
}

@Riverpod(keepAlive: true)
Future<List<MuscleGroup>> muscleGroups(Ref ref) {
  final repo = ref.watch(workoutsRepositoryProvider);
  return repo.getMuscleGroups();
}

const _kClientFilterThreshold = 50;

/// [selectedGroups] is a comma-separated string (e.g. "chest,back") to
/// ensure stable equality for the family provider key.
@riverpod
Future<List<WorkoutBrief>> filteredWorkouts(
  Ref ref, {
  String search = '',
  String selectedGroups = '',
}) async {
  final repo = ref.watch(workoutsRepositoryProvider);
  final allWorkouts = ref.watch(workoutsListProvider).valueOrNull;

  final hasSearch = search.isNotEmpty;
  final groups =
      selectedGroups.isEmpty ? <String>[] : selectedGroups.split(',');
  final hasGroups = groups.isNotEmpty;

  // No filters active — return full list
  if (!hasSearch && !hasGroups) {
    return allWorkouts ?? await repo.getWorkouts();
  }

  // If we have the full list cached and it's small, filter client-side
  if (allWorkouts != null && allWorkouts.length <= _kClientFilterThreshold) {
    return allWorkouts.where((w) {
      if (hasSearch && !w.title.toLowerCase().contains(search.toLowerCase())) {
        return false;
      }
      if (hasGroups && !w.muscleGroups.any((g) => groups.contains(g))) {
        return false;
      }
      return true;
    }).toList();
  }

  // Large list or not cached — delegate to API
  return repo.getWorkouts(
    search: hasSearch ? search : null,
    muscleGroups: hasGroups ? groups : null,
  );
}

@riverpod
Future<WorkoutDetail> workoutDetail(
    Ref ref, (String id, String? programDayId) args) {
  final repo = ref.watch(workoutsRepositoryProvider);
  return repo.getWorkoutDetail(args.$1, programDayId: args.$2);
}
