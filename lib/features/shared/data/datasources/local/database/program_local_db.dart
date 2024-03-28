import 'package:gymprime/core/resources/local_database.dart';
import 'package:gymprime/features/shared/data/models/program_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

abstract class ProgramLocalDB implements LocalDatabaseTable {
  Future<int> insert(ProgramModel program);
  Future<List<ProgramModel>> fetchAll();
  Future<List<ProgramModel>> fetchById(ObjectId id);
  Future<int> update(
    ObjectId id,
    ProgramModel program,
  );
  Future<int> delete(ObjectId id);
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
  Future<int> insert(ProgramModel program) async {
    return await database.insert(tableName, program.toJson());
  }

  @override
  Future<List<ProgramModel>> fetchAll() async {
    final programsMaps = await database.query(tableName);
    return ProgramModel.fromJsonToList(programsMaps);
  }

  @override
  Future<List<ProgramModel>> fetchById(ObjectId id) async {
    final programsMaps = await database.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return ProgramModel.fromJsonToList(programsMaps);
  }

  @override
  Future<int> update(
    ObjectId id,
    ProgramModel program,
  ) async {
    return await database.update(
      tableName,
      program.toJson(),
      where: 'id = ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id],
    );
  }

  @override
  Future<int> delete(ObjectId id) async {
    return await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id.toString()],
    );
  }
}
