import 'package:gymprime/core/resources/local_database.dart';
import 'package:gymprime/features/shared/data/models/exercise_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

abstract class ExerciseLocalDB implements LocalDatabaseTable {
  Future<int> insert({required ExerciseModel exerciseModel});
  Future<List<ExerciseModel>> fetchAll();
  Future<ExerciseModel> fetchById({required ObjectId id});
  Future<int> update({
    required ObjectId id,
    required ExerciseModel exerciseModel,
  });
  Future<int> delete({required ObjectId id});
}

class ExerciseLocalDBImpl implements ExerciseLocalDB {
  late final Database database;
  final String tableName;

  ExerciseLocalDBImpl({
    required this.tableName,
  });

  @override
  Future<void> initialize(Database database) async {
    this.database = database;
    await this.database.execute(
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

  @override
  Future<int> insert({required ExerciseModel exerciseModel}) async {
    return await database.insert(tableName, exerciseModel.toJson());
  }

  @override
  Future<List<ExerciseModel>> fetchAll() async {
    final exerciseModels = await database.query(tableName);
    return exerciseModels
        .map((modelMap) => ExerciseModel.fromJson(modelMap))
        .toList();
  }

  @override
  Future<ExerciseModel> fetchById({required ObjectId id}) async {
    final exerciseModel = await database.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return ExerciseModel.fromJson(exerciseModel.first);
  }

  @override
  Future<int> update({
    required ObjectId id,
    required ExerciseModel exerciseModel,
  }) async {
    return await database.update(
      tableName,
      exerciseModel.toJson(),
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
