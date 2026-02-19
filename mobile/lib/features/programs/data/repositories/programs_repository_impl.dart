import 'package:fitlabel/features/programs/data/datasources/programs_remote_data_source.dart';
import 'package:fitlabel/features/programs/domain/models/program.dart';
import 'package:fitlabel/features/programs/domain/repositories/programs_repository.dart';

class ProgramsRepositoryImpl implements ProgramsRepository {
  final ProgramsRemoteDataSource _dataSource;

  ProgramsRepositoryImpl({required ProgramsRemoteDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<List<Program>> getPrograms({String? difficulty}) async {
    final list = await _dataSource.getPrograms(difficulty: difficulty);
    return list
        .map((json) => Program.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<ProgramDetail> getProgramDetail(String id) async {
    final json = await _dataSource.getProgramDetail(id);
    return ProgramDetail.fromJson(json);
  }

  @override
  Future<ProgramProgress> enroll(String programId) async {
    final json = await _dataSource.enroll(programId);
    return ProgramProgress.fromJson(json);
  }

  @override
  Future<ProgramProgress> getProgress(String programId) async {
    final json = await _dataSource.getProgress(programId);
    return ProgramProgress.fromJson(json);
  }
}
