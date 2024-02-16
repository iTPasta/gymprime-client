import 'package:gymprime/features/shared/data/models/recipe_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

class RecipeLocalDB {
  Database? database;
  String? tableName;

  static final RecipeLocalDB _instance = RecipeLocalDB._internal();

  RecipeLocalDB._internal();

  factory RecipeLocalDB() {
    assert(
      _instance.database != null && _instance.tableName != null,
      "Local database not initialized yet.",
    );

    return _instance;
  }

  factory RecipeLocalDB.initialize({
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
          name TEXT,
          description TEXT,
          ingredients TEXT NOT NULL
        );
      ''',
    );
  }

  Future<int> insert({required RecipeModel recipeModel}) async {
    return await database!.insert(tableName!, recipeModel.toJson());
  }

  Future<List<RecipeModel>> fetchAll() async {
    final recipeModels = await database!.query(tableName!);
    return recipeModels
        .map((modelMap) => RecipeModel.fromJson(modelMap))
        .toList();
  }

  Future<RecipeModel> fetchById({required ObjectId id}) async {
    final recipeModel = await database!.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return RecipeModel.fromJson(recipeModel.first);
  }

  Future<int> update({
    required ObjectId id,
    required RecipeModel recipeModel,
  }) async {
    return await database!.update(
      tableName!,
      recipeModel.toJson(),
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
