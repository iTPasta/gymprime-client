import 'package:gymprime/core/resources/local_database.dart';
import 'package:gymprime/features/shared/data/models/training_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

abstract class TrainingLocalDB implements LocalDatabaseTable {
  Future<int> insert({required TrainingModel trainingModel});
  Future<List<TrainingModel>> fetchAll();
  Future<TrainingModel> fetchById({required ObjectId id});
  Future<int> update({
    required ObjectId id,
    required TrainingModel trainingModel,
  });
  Future<int> delete({required ObjectId id});
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
  Future<int> insert({required TrainingModel trainingModel}) async {
    return await database.insert(tableName, trainingModel.toJson());
  }

  @override
  Future<List<TrainingModel>> fetchAll() async {
    final trainingModels = await database.query(tableName);
    return trainingModels
        .map((modelMap) => TrainingModel.fromJson(modelMap))
        .toList();
  }

  @override
  Future<TrainingModel> fetchById({required ObjectId id}) async {
    final trainingModel = await database.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return TrainingModel.fromJson(trainingModel.first);
  }

  @override
  Future<int> update({
    required ObjectId id,
    required TrainingModel trainingModel,
  }) async {
    return await database.update(
      tableName,
      trainingModel.toJson(),
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
