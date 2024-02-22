import 'package:gymprime/core/resources/local_database.dart';
import 'package:gymprime/features/shared/data/models/program_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

abstract class ProgramLocalDB implements LocalDatabaseTable {
  Future<int> insert({required ProgramModel programModel});
  Future<List<ProgramModel>> fetchAll();
  Future<ProgramModel> fetchById({required ObjectId id});
  Future<int> update({
    required ObjectId id,
    required ProgramModel programModel,
  });
  Future<int> delete({required ObjectId id});
}

class ProgramLocalDBImpl implements ProgramLocalDB {
  late final Database database;
  final String tableName;

  ProgramLocalDBImpl({
    required this.tableName,
  });

  @override
  Future<void> initialize(Database database) async {
    this.database = database;
    await this.database.execute(
      '''
        CREATE TABLE IF NOT EXISTS $tableName (
          id  TEXT PRIMARY KEY NOT NULL,
          name TEXT,
          description TEXT,
          programs TEXT NOT NULL,
          trainings TEXT NOT NULL,
          goal TEXT NOT NULL
        );
      ''',
    );
  }

  @override
  Future<int> insert({required ProgramModel programModel}) async {
    return await database.insert(tableName, programModel.toJson());
  }

  @override
  Future<List<ProgramModel>> fetchAll() async {
    final programModels = await database.query(tableName);
    return programModels
        .map((modelMap) => ProgramModel.fromJson(modelMap))
        .toList();
  }

  @override
  Future<ProgramModel> fetchById({required ObjectId id}) async {
    final programModel = await database.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return ProgramModel.fromJson(programModel.first);
  }

  @override
  Future<int> update({
    required ObjectId id,
    required ProgramModel programModel,
  }) async {
    return await database.update(
      tableName,
      programModel.toJson(),
      where: 'id = ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id],
    );
  }

  @override
  Future<int> delete({required ObjectId id}) async {
    return await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id.toString()],
    );
  }
}
