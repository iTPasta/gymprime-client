import 'package:gymprime/features/shared/data/datasources/local/database/recipe_local_db.dart';
import 'package:gymprime/features/shared/data/models/recipe_model.dart';
import 'package:objectid/objectid.dart';

abstract class RecipeLocalDataSource {
  Future<List<RecipeModel>> getMyRecipes();
  Future<RecipeModel> getRecipe(ObjectId id);
  Future<RecipeModel> createRecipe(RecipeModel recipe);
  Future<RecipeModel> updateRecipe(ObjectId id, RecipeModel recipe);
  Future<ObjectId> deleteRecipe(ObjectId id);
}

class RecipeLocalDataSourceImpl implements RecipeLocalDataSource {
  final RecipeLocalDB _recipeLocalDB = RecipeLocalDB();

  @override
  Future<RecipeModel> createRecipe(RecipeModel recipe) {
    _recipeLocalDB.insert(recipeModel: recipe);
    return Future.value(recipe);
  }

  @override
  Future<ObjectId> deleteRecipe(ObjectId id) {
    _recipeLocalDB.delete(id: id);
    return Future.value(id);
  }

  @override
  Future<RecipeModel> getRecipe(ObjectId id) {
    return _recipeLocalDB.fetchById(id: id);
  }

  @override
  Future<List<RecipeModel>> getMyRecipes() {
    return _recipeLocalDB.fetchAll();
  }

  @override
  Future<RecipeModel> updateRecipe(ObjectId id, RecipeModel recipe) {
    _recipeLocalDB.update(id: id, recipeModel: recipe);
    return Future.value(recipe);
  }
}
