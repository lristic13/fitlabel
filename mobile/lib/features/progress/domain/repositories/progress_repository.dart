import 'package:fitlabel/features/progress/domain/models/progress.dart';

abstract class ProgressRepository {
  Future<PaginatedHistory> getHistory({String? cursor});
  Future<ProgressStats> getStats();
}
