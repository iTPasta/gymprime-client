import 'package:gymprime/features/shared/data/models/training_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

class TrainingLocalDB {
  Database? database;
  String? tableName;

  static final TrainingLocalDB _instance = TrainingLocalDB._internal();

  TrainingLocalDB._internal();

  factory TrainingLocalDB() {
    assert(
      _instance.database != null && _instance.tableName != null,
      "Local database not initialized yet.",
    );

    return _instance;
  }

  factory TrainingLocalDB.initialize({
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
          notes TEXT,
          sets TEXT NOT NULL
        );
      ''',
    );
  }

  Future<int> insert({required TrainingModel trainingModel}) async {
    return await database!.insert(tableName!, trainingModel.toJson());
  }

  Future<List<TrainingModel>> fetchAll() async {
    final trainingModels = await database!.query(tableName!);
    return trainingModels
        .map((modelMap) => TrainingModel.fromJson(modelMap))
        .toList();
  }

  Future<TrainingModel> fetchById({required ObjectId id}) async {
    final trainingModel = await database!.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return TrainingModel.fromJson(trainingModel.first);
  }

  Future<int> update({
    required ObjectId id,
    required TrainingModel trainingModel,
  }) async {
    return await database!.update(
      tableName!,
      trainingModel.toJson(),
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
