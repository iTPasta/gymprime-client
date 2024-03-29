import 'package:gymprime/core/resources/local_database.dart';
import 'package:gymprime/features/shared/data/models/training_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

abstract class TrainingLocalDB implements LocalDatabaseTable {
  Future<int> insert(TrainingModel training);
  Future<List<TrainingModel>> fetchAll();
  Future<List<TrainingModel>> fetchById(ObjectId id);
  Future<int> update(
    ObjectId id,
    TrainingModel training,
  );
  Future<int> delete(ObjectId id);
}

class TrainingLocalDBImpl implements TrainingLocalDB {
  late final Database database;
  final String tableName;

  TrainingLocalDBImpl({
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
          notes TEXT,
          sets TEXT NOT NULL
        );
      ''',
    );
  }

  @override
  Future<int> insert(TrainingModel training) async {
    return await database.insert(tableName, training.toJson());
  }

  @override
  Future<List<TrainingModel>> fetchAll() async {
    final trainingsMaps = await database.query(tableName);
    return TrainingModel.fromJsonToList(trainingsMaps);
  }

  @override
  Future<List<TrainingModel>> fetchById(ObjectId id) async {
    final trainingsMaps = await database.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return TrainingModel.fromJsonToList(trainingsMaps);
  }

  @override
  Future<int> update(
    ObjectId id,
    TrainingModel training,
  ) async {
    return await database.update(
      tableName,
      training.toJson(),
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
