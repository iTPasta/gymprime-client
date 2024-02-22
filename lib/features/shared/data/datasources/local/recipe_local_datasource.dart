import 'package:gymprime/features/shared/data/datasources/local/database/recipe_local_db.dart';
import 'package:gymprime/features/shared/data/models/recipe_model.dart';
import 'package:objectid/objectid.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class RecipeLocalDataSource {
  Future<List<RecipeModel>> getMyRecipes();
  Future<RecipeModel> getRecipe(ObjectId id);
  Future<RecipeModel> createRecipe(RecipeModel recipe);
  Future<RecipeModel> updateRecipe(ObjectId id, RecipeModel recipe);
  Future<ObjectId> deleteRecipe(ObjectId id);
  int? getRecipesLastUpdate();
  void setRecipesLastUpdate(int recipesLastUpdate);
}

class RecipeLocalDataSourceImpl implements RecipeLocalDataSource {
  final RecipeLocalDB recipeLocalDB;
  final SharedPreferences sharedPreferences;

  RecipeLocalDataSourceImpl({
    required this.recipeLocalDB,
    required this.sharedPreferences,
  });

  @override
  Future<RecipeModel> createRecipe(RecipeModel recipe) {
    recipeLocalDB.insert(recipeModel: recipe);
    return Future.value(recipe);
  }

  @override
  Future<ObjectId> deleteRecipe(ObjectId id) {
    recipeLocalDB.delete(id: id);
    return Future.value(id);
  }

  @override
  Future<RecipeModel> getRecipe(ObjectId id) {
    return recipeLocalDB.fetchById(id: id);
  }

  @override
  Future<List<RecipeModel>> getMyRecipes() {
    return recipeLocalDB.fetchAll();
  }

  @override
  Future<RecipeModel> updateRecipe(ObjectId id, RecipeModel recipe) {
    recipeLocalDB.update(id: id, recipeModel: recipe);
    return Future.value(recipe);
  }

  @override
  int? getRecipesLastUpdate() {
    return sharedPreferences.getInt("recipesLastUpdate");
  }

  @override
  void setRecipesLastUpdate(int recipesLastUpdate) {
    sharedPreferences.setInt("recipesLastUpdate", recipesLastUpdate);
  }
}
