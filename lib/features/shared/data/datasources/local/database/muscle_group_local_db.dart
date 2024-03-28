import 'package:gymprime/core/resources/local_database.dart';
import 'package:gymprime/features/shared/data/models/muscle_group_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

abstract class MuscleGroupLocalDB implements LocalDatabaseTable {
  Future<int> insert(MuscleGroupModel muscleGroup);
  Future<List<MuscleGroupModel>> fetchAll();
  Future<List<MuscleGroupModel>> fetchById(ObjectId id);
  Future<int> update(
    ObjectId id,
    MuscleGroupModel muscleGroup,
  );
  Future<int> delete(ObjectId id);
}

class MuscleGroupLocalDBImpl implements MuscleGroupLocalDB {
  late final Database database;
  final String tableName;

  MuscleGroupLocalDBImpl({
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
          muscles TEXT NOT NULL
        );
      ''',
    );
  }

  @override
  Future<int> insert(MuscleGroupModel muscleGroup) async {
    return await database.insert(tableName, muscleGroup.toJson());
  }

  @override
  Future<List<MuscleGroupModel>> fetchAll() async {
    final muscleGroupsMaps = await database.query(tableName);
    return MuscleGroupModel.fromJsonToList(muscleGroupsMaps);
  }

  @override
  Future<List<MuscleGroupModel>> fetchById(ObjectId id) async {
    final muscleGroupsMaps = await database.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return MuscleGroupModel.fromJsonToList(muscleGroupsMaps);
  }

  @override
  Future<int> update(
    ObjectId id,
    MuscleGroupModel muscleGroup,
  ) async {
    return await database.update(
      tableName,
      muscleGroup.toJson(),
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
