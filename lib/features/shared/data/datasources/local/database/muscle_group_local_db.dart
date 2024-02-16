import 'package:gymprime/features/shared/data/models/muscle_group_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

class MuscleGroupLocalDB {
  Database? database;
  String? tableName;

  static final MuscleGroupLocalDB _instance = MuscleGroupLocalDB._internal();

  MuscleGroupLocalDB._internal();

  factory MuscleGroupLocalDB() {
    assert(
      _instance.database != null && _instance.tableName != null,
      "Local database not initialized yet.",
    );

    return _instance;
  }

  factory MuscleGroupLocalDB.initialize({
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
          muscles TEXT NOT NULL
        );
      ''',
    );
  }

  Future<int> insert({required MuscleGroupModel muscleGroupModel}) async {
    return await database!.insert(tableName!, muscleGroupModel.toJson());
  }

  Future<List<MuscleGroupModel>> fetchAll() async {
    final muscleGroupModels = await database!.query(tableName!);
    return muscleGroupModels
        .map((modelMap) => MuscleGroupModel.fromJson(modelMap))
        .toList();
  }

  Future<MuscleGroupModel> fetchById({required ObjectId id}) async {
    final muscleGroupModel = await database!.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return MuscleGroupModel.fromJson(muscleGroupModel.first);
  }

  Future<int> update({
    required ObjectId id,
    required MuscleGroupModel muscleGroupModel,
  }) async {
    return await database!.update(
      tableName!,
      muscleGroupModel.toJson(),
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
