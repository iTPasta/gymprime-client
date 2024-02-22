import 'package:gymprime/core/resources/local_database.dart';
import 'package:gymprime/features/shared/data/models/muscle_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

abstract class MuscleLocalDB implements LocalDatabaseTable {
  Future<int> insert({required MuscleModel muscleModel});
  Future<List<MuscleModel>> fetchAll();
  Future<MuscleModel> fetchById({required ObjectId id});
  Future<int> update({
    required ObjectId id,
    required MuscleModel muscleModel,
  });
  Future<int> delete({required ObjectId id});
}

class MuscleLocalDBImpl implements MuscleLocalDB {
  late final Database database;
  final String tableName;

  MuscleLocalDBImpl({
    required this.tableName,
  });

  @override
  Future<void> initialize(Database database) async {
    this.database = database;
    await this.database.execute(
      '''
        CREATE TABLE IF NOT EXISTS $tableName (
          id  TEXT PRIMARY KEY NOT NULL,
          names TEXT NOT NULL,
          descriptions TEXT NOT NULL,
          muscles TEXT NOT NULL,
          muscleGroup TEXT
        );
      ''',
    );
  }

  @override
  Future<int> insert({required MuscleModel muscleModel}) async {
    return await database.insert(tableName, muscleModel.toJson());
  }

  @override
  Future<List<MuscleModel>> fetchAll() async {
    final muscleModels = await database.query(tableName);
    return muscleModels
        .map((modelMap) => MuscleModel.fromJson(modelMap))
        .toList();
  }

  @override
  Future<MuscleModel> fetchById({required ObjectId id}) async {
    final muscleModel = await database.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return MuscleModel.fromJson(muscleModel.first);
  }

  @override
  Future<int> update({
    required ObjectId id,
    required MuscleModel muscleModel,
  }) async {
    return await database.update(
      tableName,
      muscleModel.toJson(),
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
