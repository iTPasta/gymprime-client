import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/features/shared/data/datasources/local/database/recipe_local_db.dart';
import 'package:gymprime/features/shared/data/models/recipe_model.dart';
import 'package:objectid/objectid.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class RecipeLocalDataSource {
  Future<List<RecipeModel>> getMyRecipes();
  Future<RecipeModel> getRecipe(ObjectId id);
  Future<void> createRecipe(RecipeModel recipe);
  Future<void> updateRecipe(ObjectId id, RecipeModel recipe);
  Future<void> deleteRecipe(ObjectId id);
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
  Future<List<RecipeModel>> getMyRecipes() async {
    return await recipeLocalDB.fetchAll();
  }

  @override
  Future<RecipeModel> getRecipe(ObjectId id) async {
    final List<RecipeModel> recipes = await recipeLocalDB.fetchById(id);
    if (recipes.isEmpty) {
      throw NoRowAffectedException();
    } else if (1 < recipes.length) {
      throw MultipleRowsAffectedException();
    } else {
      return recipes.first;
    }
  }

  @override
  Future<void> createRecipe(RecipeModel recipe) async {
    final int id = await recipeLocalDB.insert(recipe);
    if (id == 0) {
      throw NoRowInsertedException();
    }
  }

  @override
  Future<void> updateRecipe(ObjectId? id, RecipeModel recipe) async {
    final int rowsUpdated = await recipeLocalDB.update(id ?? recipe.id, recipe);
    if (rowsUpdated == 0) {
      throw NoRowAffectedException();
    } else if (1 < rowsUpdated) {
      throw MultipleRowsAffectedException();
    }
  }

  @override
  Future<void> deleteRecipe(ObjectId id) async {
    final int rowDeleted = await recipeLocalDB.delete(id);
    if (rowDeleted == 0) {
      throw NoRowAffectedException();
    } else if (1 < rowDeleted) {
      throw MultipleRowsAffectedException();
    }
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
