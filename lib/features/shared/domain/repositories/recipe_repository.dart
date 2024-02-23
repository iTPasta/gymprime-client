import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/features/shared/domain/entities/recipe_entity.dart';
import 'package:objectid/objectid.dart';

abstract class RecipeRepository {
  Future<DataState<List<RecipeEntity>>> getAllRecipes();
  Future<DataState<List<RecipeEntity>>> getMyRecipes();
  Future<DataState<RecipeEntity>> getRecipe(ObjectId id);
  Future<DataState<RecipeEntity>> createRecipe(RecipeEntity recipeEntity);
  Future<DataState<RecipeEntity>> updateRecipe(RecipeEntity recipeEntity);
  Future<DataState<ObjectId>> deleteRecipe(ObjectId id);
  Future<DataState<void>> syncMyRecipes();
}
