import 'package:gymprime/core/resources/local_database.dart';
import 'package:gymprime/features/shared/data/models/exercise_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

abstract class ExerciseLocalDB implements LocalDatabaseTable {
  Future<int> insert(ExerciseModel exercise);
  Future<List<ExerciseModel>> fetchAll();
  Future<List<ExerciseModel>> fetchById(ObjectId id);
  Future<int> update(
    ObjectId id,
    ExerciseModel exercise,
  );
  Future<int> delete(ObjectId id);
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
  Future<int> insert(ExerciseModel exercise) async {
    return await database.insert(tableName, exercise.toJson());
  }

  @override
  Future<List<ExerciseModel>> fetchAll() async {
    final exercisesMaps = await database.query(tableName);
    return ExerciseModel.fromJsonToList(exercisesMaps);
  }

  @override
  Future<List<ExerciseModel>> fetchById(ObjectId id) async {
    final exercisesMaps = await database.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return ExerciseModel.fromJsonToList(exercisesMaps);
  }

  @override
  Future<int> update(
    ObjectId id,
    ExerciseModel exercise,
  ) async {
    return await database.update(
      tableName,
      exercise.toJson(),
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
