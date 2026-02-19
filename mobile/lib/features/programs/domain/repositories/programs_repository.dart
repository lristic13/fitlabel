import 'package:fitlabel/features/programs/domain/models/program.dart';

abstract class ProgramsRepository {
  Future<List<Program>> getPrograms({String? difficulty});
  Future<ProgramDetail> getProgramDetail(String id);
  Future<ProgramProgress> enroll(String programId);
  Future<ProgramProgress> getProgress(String programId);
}
