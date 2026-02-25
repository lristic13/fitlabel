import 'package:fitlabel/features/progress/data/datasources/progress_remote_data_source.dart';
import 'package:fitlabel/features/progress/domain/models/progress.dart';
import 'package:fitlabel/features/progress/domain/repositories/progress_repository.dart';

class ProgressRepositoryImpl implements ProgressRepository {
  final ProgressRemoteDataSource _dataSource;

  ProgressRepositoryImpl({required ProgressRemoteDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<PaginatedHistory> getHistory({String? cursor}) async {
    final json = await _dataSource.getHistory(cursor: cursor);
    return PaginatedHistory.fromJson(json);
  }

  @override
  Future<ProgressStats> getStats() async {
    final json = await _dataSource.getStats();
    return ProgressStats.fromJson(json);
  }
}
