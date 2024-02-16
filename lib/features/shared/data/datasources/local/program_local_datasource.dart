import 'package:gymprime/features/shared/data/datasources/local/database/program_local_db.dart';
import 'package:gymprime/features/shared/data/models/program_model.dart';
import 'package:objectid/objectid.dart';

abstract class ProgramLocalDataSource {
  Future<List<ProgramModel>> getMyPrograms();
  Future<ProgramModel> getProgram(ObjectId id);
  Future<ProgramModel> createProgram(ProgramModel program);
  Future<ProgramModel> updateProgram(ObjectId id, ProgramModel program);
  Future<ObjectId> deleteProgram(ObjectId id);
}

class ProgramLocalDataSourceImpl implements ProgramLocalDataSource {
  final ProgramLocalDB _programLocalDB = ProgramLocalDB();

  @override
  Future<ProgramModel> createProgram(ProgramModel program) {
    _programLocalDB.insert(programModel: program);
    return Future.value(program);
  }

  @override
  Future<ObjectId> deleteProgram(ObjectId id) {
    _programLocalDB.delete(id: id);
    return Future.value(id);
  }

  @override
  Future<ProgramModel> getProgram(ObjectId id) {
    return _programLocalDB.fetchById(id: id);
  }

  @override
  Future<List<ProgramModel>> getMyPrograms() {
    return _programLocalDB.fetchAll();
  }

  @override
  Future<ProgramModel> updateProgram(ObjectId id, ProgramModel program) {
    _programLocalDB.update(id: id, programModel: program);
    return Future.value(program);
  }
}
