import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/features/shared/data/datasources/local/database/program_local_db.dart';
import 'package:gymprime/features/shared/data/models/program_model.dart';
import 'package:objectid/objectid.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProgramLocalDataSource {
  Future<List<ProgramModel>> getMyPrograms();
  Future<ProgramModel> getProgram(ObjectId id);
  Future<void> createProgram(ProgramModel program);
  Future<void> updateProgram(ObjectId id, ProgramModel program);
  Future<void> deleteProgram(ObjectId id);
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
  Future<List<ProgramModel>> getMyPrograms() async {
    return await programLocalDB.fetchAll();
  }

  @override
  Future<ProgramModel> getProgram(ObjectId id) async {
    final List<ProgramModel> programs = await programLocalDB.fetchById(id);
    if (programs.isEmpty) {
      throw NoRowAffectedException();
    } else if (1 < programs.length) {
      throw MultipleRowsAffectedException();
    } else {
      return programs.first;
    }
  }

  @override
  Future<void> createProgram(ProgramModel program) async {
    final int id = await programLocalDB.insert(program);
    if (id == 0) {
      throw NoRowInsertedException();
    }
  }

  @override
  Future<void> updateProgram(ObjectId? id, ProgramModel program) async {
    final int rowsUpdated =
        await programLocalDB.update(id ?? program.id, program);
    if (rowsUpdated == 0) {
      throw NoRowAffectedException();
    } else if (1 < rowsUpdated) {
      throw MultipleRowsAffectedException();
    }
  }

  @override
  Future<void> deleteProgram(ObjectId id) async {
    final int rowDeleted = await programLocalDB.delete(id);
    if (rowDeleted == 0) {
      throw NoRowAffectedException();
    } else if (1 < rowDeleted) {
      throw MultipleRowsAffectedException();
    }
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
