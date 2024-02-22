import 'package:gymprime/features/shared/data/datasources/local/database/program_local_db.dart';
import 'package:gymprime/features/shared/data/models/program_model.dart';
import 'package:objectid/objectid.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProgramLocalDataSource {
  Future<List<ProgramModel>> getMyPrograms();
  Future<ProgramModel> getProgram(ObjectId id);
  Future<ProgramModel> createProgram(ProgramModel program);
  Future<ProgramModel> updateProgram(ObjectId id, ProgramModel program);
  Future<ObjectId> deleteProgram(ObjectId id);
  int? getProgramsLastUpdate();
  void setProgramsLastUpdate(int programsLastUpdate);
}

class ProgramLocalDataSourceImpl implements ProgramLocalDataSource {
  final ProgramLocalDB programLocalDB;
  final SharedPreferences sharedPreferences;

  ProgramLocalDataSourceImpl({
    required this.programLocalDB,
    required this.sharedPreferences,
  });

  @override
  Future<ProgramModel> createProgram(ProgramModel program) {
    programLocalDB.insert(programModel: program);
    return Future.value(program);
  }

  @override
  Future<ObjectId> deleteProgram(ObjectId id) {
    programLocalDB.delete(id: id);
    return Future.value(id);
  }

  @override
  Future<ProgramModel> getProgram(ObjectId id) {
    return programLocalDB.fetchById(id: id);
  }

  @override
  Future<List<ProgramModel>> getMyPrograms() {
    return programLocalDB.fetchAll();
  }

  @override
  Future<ProgramModel> updateProgram(ObjectId id, ProgramModel program) {
    programLocalDB.update(id: id, programModel: program);
    return Future.value(program);
  }

  @override
  int? getProgramsLastUpdate() {
    return sharedPreferences.getInt("programsLastUpdate");
  }

  @override
  void setProgramsLastUpdate(int programsLastUpdate) {
    sharedPreferences.setInt("programsLastUpdate", programsLastUpdate);
  }
}
