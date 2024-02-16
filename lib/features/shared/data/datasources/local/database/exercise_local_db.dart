import 'package:gymprime/features/shared/data/models/exercise_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

class ExerciseLocalDB {
  Database? database;
  String? tableName;

  static final ExerciseLocalDB _instance = ExerciseLocalDB._internal();

  ExerciseLocalDB._internal();

  factory ExerciseLocalDB() {
    assert(
      _instance.database != null && _instance.tableName != null,
      "Local database not initialized yet.",
    );

    return _instance;
  }

  factory ExerciseLocalDB.initialize({
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
          names  TEXT NOT NULL,
          descriptions TEXT NOT NULL,
          muscles TEXT NOT NULL,
          muscleGroup TEXT
        );
      ''',
    );
  }

  Future<int> insert({required ExerciseModel exerciseModel}) async {
    return await database!.insert(tableName!, exerciseModel.toJson());
  }

  Future<List<ExerciseModel>> fetchAll() async {
    final exerciseModels = await database!.query(tableName!);
    return exerciseModels
        .map((modelMap) => ExerciseModel.fromJson(modelMap))
        .toList();
  }

  Future<ExerciseModel> fetchById({required ObjectId id}) async {
    final exerciseModel = await database!.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return ExerciseModel.fromJson(exerciseModel.first);
  }

  Future<int> update({
    required ObjectId id,
    required ExerciseModel exerciseModel,
  }) async {
    return await database!.update(
      tableName!,
      exerciseModel.toJson(),
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
