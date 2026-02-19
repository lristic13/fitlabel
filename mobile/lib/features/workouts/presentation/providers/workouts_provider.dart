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
Future<WorkoutDetail> workoutDetail(Ref ref, String id) {
  final repo = ref.watch(workoutsRepositoryProvider);
  return repo.getWorkoutDetail(id);
}
