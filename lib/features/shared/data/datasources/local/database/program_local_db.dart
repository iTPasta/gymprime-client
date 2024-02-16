import 'package:gymprime/features/shared/data/models/program_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

class ProgramLocalDB {
  Database? database;
  String? tableName;

  static final ProgramLocalDB _instance = ProgramLocalDB._internal();

  ProgramLocalDB._internal();

  factory ProgramLocalDB() {
    assert(
      _instance.database != null && _instance.tableName != null,
      "Local database not initialized yet.",
    );

    return _instance;
  }

  factory ProgramLocalDB.initialize({
    required Database database,
    required String tableName,
  }) {
    assert(
      _instance.database == null || _instance.tableName == null,
      "Local database already initialized.",
    );

    _instance.database = database;
    _instance.tableName = tableName;
    _instance.createTable();

    return _instance;
  }

  Future<void> createTable() async {
    await database!.execute(
      '''
        CREATE TABLE IF NOT EXISTS $tableName (
          id  TEXT PRIMARY KEY NOT NULL,
          name TEXT,
          description TEXT,
          exercises TEXT NOT NULL,
          trainings TEXT NOT NULL,
          goal TEXT NOT NULL
        );
      ''',
    );
  }

  Future<int> insert({required ProgramModel programModel}) async {
    return await database!.insert(tableName!, programModel.toJson());
  }

  Future<List<ProgramModel>> fetchAll() async {
    final programModels = await database!.query(tableName!);
    return programModels
        .map((modelMap) => ProgramModel.fromJson(modelMap))
        .toList();
  }

  Future<ProgramModel> fetchById({required ObjectId id}) async {
    final programModel = await database!.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return ProgramModel.fromJson(programModel.first);
  }

  Future<int> update({
    required ObjectId id,
    required ProgramModel programModel,
  }) async {
    return await database!.update(
      tableName!,
      programModel.toJson(),
      where: 'id = ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id],
    );
  }

  Future<int> delete({required ObjectId id}) async {
    return await database!.delete(
      tableName!,
      where: 'id = ?',
      whereArgs: [id.toString()],
    );
  }
}
