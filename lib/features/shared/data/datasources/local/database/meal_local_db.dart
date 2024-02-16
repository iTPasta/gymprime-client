import 'package:gymprime/features/shared/data/models/meal_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

class MealLocalDB {
  Database? database;
  String? tableName;

  static final MealLocalDB _instance = MealLocalDB._internal();

  MealLocalDB._internal();

  factory MealLocalDB() {
    assert(
      _instance.database != null && _instance.tableName != null,
      "Local database not initialized yet.",
    );

    return _instance;
  }

  factory MealLocalDB.initialize({
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
          name  TEXT,
          description TEXT,
          aliments TEXT NOT NULL,
          recipes TEXT NOT NULL
        );
      ''',
    );
  }

  Future<int> insert({required MealModel mealModel}) async {
    return await database!.insert(tableName!, mealModel.toJson());
  }

  Future<List<MealModel>> fetchAll() async {
    final mealModels = await database!.query(tableName!);
    return mealModels.map((modelMap) => MealModel.fromJson(modelMap)).toList();
  }

  Future<MealModel> fetchById({required ObjectId id}) async {
    final mealModel = await database!.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return MealModel.fromJson(mealModel.first);
  }

  Future<int> update({
    required ObjectId id,
    required MealModel mealModel,
  }) async {
    return await database!.update(
      tableName!,
      mealModel.toJson(),
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
