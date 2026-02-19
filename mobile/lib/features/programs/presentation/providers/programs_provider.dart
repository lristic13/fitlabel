import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fitlabel/features/programs/data/datasources/programs_remote_data_source.dart';
import 'package:fitlabel/features/programs/data/repositories/programs_repository_impl.dart';
import 'package:fitlabel/features/programs/domain/models/program.dart';
import 'package:fitlabel/features/programs/domain/repositories/programs_repository.dart';
import 'package:fitlabel/shared/providers/core_providers.dart';

part 'programs_provider.g.dart';

@Riverpod(keepAlive: true)
ProgramsRemoteDataSource programsRemoteDataSource(Ref ref) {
  final client = ref.watch(apiClientProvider);
  return ProgramsRemoteDataSource(client: client);
}

@Riverpod(keepAlive: true)
ProgramsRepository programsRepository(Ref ref) {
  final dataSource = ref.watch(programsRemoteDataSourceProvider);
  return ProgramsRepositoryImpl(dataSource: dataSource);
}

@riverpod
Future<List<Program>> programsList(Ref ref) {
  final repo = ref.watch(programsRepositoryProvider);
  return repo.getPrograms();
}

@riverpod
Future<ProgramDetail> programDetail(Ref ref, String id) {
  final repo = ref.watch(programsRepositoryProvider);
  return repo.getProgramDetail(id);
}
