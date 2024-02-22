import 'package:gymprime/core/resources/local_database.dart';
import 'package:gymprime/features/shared/data/models/muscle_group_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

abstract class MuscleGroupLocalDB implements LocalDatabaseTable {
  Future<int> insert({required MuscleGroupModel muscleGroupModel});
  Future<List<MuscleGroupModel>> fetchAll();
  Future<MuscleGroupModel> fetchById({required ObjectId id});
  Future<int> update({
    required ObjectId id,
    required MuscleGroupModel muscleGroupModel,
  });
  Future<int> delete({required ObjectId id});
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
  Future<int> insert({required MuscleGroupModel muscleGroupModel}) async {
    return await database.insert(tableName, muscleGroupModel.toJson());
  }

  @override
  Future<List<MuscleGroupModel>> fetchAll() async {
    final muscleGroupModels = await database.query(tableName);
    return muscleGroupModels
        .map((modelMap) => MuscleGroupModel.fromJson(modelMap))
        .toList();
  }

  @override
  Future<MuscleGroupModel> fetchById({required ObjectId id}) async {
    final muscleGroupModel = await database.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return MuscleGroupModel.fromJson(muscleGroupModel.first);
  }

  @override
  Future<int> update({
    required ObjectId id,
    required MuscleGroupModel muscleGroupModel,
  }) async {
    return await database.update(
      tableName,
      muscleGroupModel.toJson(),
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
