import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/features/shared/domain/entities/recipe_entity.dart';
import 'package:objectid/objectid.dart';

abstract class RecipeRepository {
  Future<DataState<List<RecipeEntity>>> getAllRecipes();
  Future<DataState<List<RecipeEntity>>> getMyRecipes();
  Future<DataState<RecipeEntity>> getRecipe(ObjectId id);
  Future<DataState<RecipeEntity>> createRecipe(RecipeEntity recipe);
  Future<DataState<RecipeEntity>> updateRecipe(RecipeEntity recipe);
  Future<DataState<ObjectId>> deleteRecipe(ObjectId id);
  Future<DataState<void>> synchronizeRecipes();
}
