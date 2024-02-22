import 'package:gymprime/core/resources/local_database.dart';
import 'package:gymprime/features/shared/data/models/recipe_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

abstract class RecipeLocalDB implements LocalDatabaseTable {
  Future<int> insert({required RecipeModel recipeModel});
  Future<List<RecipeModel>> fetchAll();
  Future<RecipeModel> fetchById({required ObjectId id});
  Future<int> update({
    required ObjectId id,
    required RecipeModel recipeModel,
  });
  Future<int> delete({required ObjectId id});
}

class RecipeLocalDBImpl implements RecipeLocalDB {
  late final Database database;
  final String tableName;

  RecipeLocalDBImpl({
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
          description TEXT,
          ingredients TEXT NOT NULL
        );
      ''',
    );
  }

  @override
  Future<int> insert({required RecipeModel recipeModel}) async {
    return await database.insert(tableName, recipeModel.toJson());
  }

  @override
  Future<List<RecipeModel>> fetchAll() async {
    final recipeModels = await database.query(tableName);
    return recipeModels
        .map((modelMap) => RecipeModel.fromJson(modelMap))
        .toList();
  }

  @override
  Future<RecipeModel> fetchById({required ObjectId id}) async {
    final recipeModel = await database.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return RecipeModel.fromJson(recipeModel.first);
  }

  @override
  Future<int> update({
    required ObjectId id,
    required RecipeModel recipeModel,
  }) async {
    return await database.update(
      tableName,
      recipeModel.toJson(),
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
