import 'package:gymprime/core/resources/local_database.dart';
import 'package:gymprime/features/shared/data/models/recipe_model.dart';
import 'package:objectid/objectid.dart';
import 'package:sqflite/sqflite.dart';

abstract class RecipeLocalDB implements LocalDatabaseTable {
  Future<int> insert(RecipeModel recipe);
  Future<List<RecipeModel>> fetchAll();
  Future<List<RecipeModel>> fetchById(ObjectId id);
  Future<int> update(
    ObjectId id,
    RecipeModel recipe,
  );
  Future<int> delete(ObjectId id);
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
  Future<int> insert(RecipeModel recipe) async {
    return await database.insert(tableName, recipe.toJson());
  }

  @override
  Future<List<RecipeModel>> fetchAll() async {
    final recipesMaps = await database.query(tableName);
    return RecipeModel.fromJsonToList(recipesMaps);
  }

  @override
  Future<List<RecipeModel>> fetchById(ObjectId id) async {
    final recipesMaps = await database.rawQuery(
      '''
        SELECT * FROM $tableName WHERE id = ? ;
      ''',
      [id],
    );
    return RecipeModel.fromJsonToList(recipesMaps);
  }

  @override
  Future<int> update(
    ObjectId id,
    RecipeModel recipe,
  ) async {
    return await database.update(
      tableName,
      recipe.toJson(),
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
