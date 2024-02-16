import 'package:gymprime/features/shared/data/models/muscle_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

class MuscleLocalDB {
  Database? database;
  String? tableName;

  static final MuscleLocalDB _instance = MuscleLocalDB._internal();

  MuscleLocalDB._internal();

  factory MuscleLocalDB() {
    assert(
      _instance.database != null && _instance.tableName != null,
      "Local database not initialized yet.",
    );

    return _instance;
  }

  factory MuscleLocalDB.initialize({
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
          names TEXT NOT NULL,
          descriptions TEXT NOT NULL,
          exercises TEXT NOT NULL,
          muscleGroup TEXT
        );
      ''',
    );
  }

  Future<int> insert({required MuscleModel muscleModel}) async {
    return await database!.insert(tableName!, muscleModel.toJson());
  }

  Future<List<MuscleModel>> fetchAll() async {
    final muscleModels = await database!.query(tableName!);
    return muscleModels
        .map((modelMap) => MuscleModel.fromJson(modelMap))
        .toList();
  }

  Future<MuscleModel> fetchById({required ObjectId id}) async {
    final muscleModel = await database!.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return MuscleModel.fromJson(muscleModel.first);
  }

  Future<int> update({
    required ObjectId id,
    required MuscleModel muscleModel,
  }) async {
    return await database!.update(
      tableName!,
      muscleModel.toJson(),
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
