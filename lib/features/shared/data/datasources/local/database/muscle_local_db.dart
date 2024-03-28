import 'package:gymprime/core/resources/local_database.dart';
import 'package:gymprime/features/shared/data/models/muscle_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

abstract class MuscleLocalDB implements LocalDatabaseTable {
  Future<int> insert(MuscleModel muscle);
  Future<List<MuscleModel>> fetchAll();
  Future<List<MuscleModel>> fetchById(ObjectId id);
  Future<int> update(
    ObjectId id,
    MuscleModel muscle,
  );
  Future<int> delete(ObjectId id);
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
  Future<int> insert(MuscleModel muscle) async {
    return await database.insert(tableName, muscle.toJson());
  }

  @override
  Future<List<MuscleModel>> fetchAll() async {
    final musclesMaps = await database.query(tableName);
    return MuscleModel.fromJsonToList(musclesMaps);
  }

  @override
  Future<List<MuscleModel>> fetchById(ObjectId id) async {
    final musclesMaps = await database.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return MuscleModel.fromJsonToList(musclesMaps);
  }

  @override
  Future<int> update(
    ObjectId id,
    MuscleModel muscle,
  ) async {
    return await database.update(
      tableName,
      muscle.toJson(),
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
