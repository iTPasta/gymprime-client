import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/core/platform/network_info.dart';
import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/features/shared/data/datasources/remote/recipe_remote_datasource.dart';
import 'package:gymprime/features/shared/data/models/recipe_model.dart';
import 'package:gymprime/features/shared/domain/entities/recipe_entity.dart';
import 'package:gymprime/features/shared/domain/repositories/recipe_repository.dart';
import 'package:objectid/objectid.dart';

class RecipeRepositoryNoCacheImpl extends RecipeRepository {
  final RecipeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RecipeRepositoryNoCacheImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<DataState<List<RecipeEntity>>> getAllRecipes() async {
    try {
      return DataSuccess(await remoteDataSource.getAllRecipes());
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<List<RecipeEntity>>> getMyRecipes() async {
    try {
      return DataSuccess((await remoteDataSource.getMyRecipes()).$1);
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<RecipeEntity>> getRecipe(ObjectId id) async {
    try {
      return DataSuccess(await remoteDataSource.getRecipe(id));
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<RecipeEntity>> createRecipe(RecipeEntity recipe) async {
    try {
      ObjectId recipeId =
          (await remoteDataSource.createRecipe(recipe.toModel())).$1;

      return DataSuccess(RecipeModel(
        id: recipeId,
        name: recipe.name,
        description: recipe.description,
        ingredients: recipe.ingredients,
      ));
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<RecipeEntity>> updateRecipe(RecipeEntity recipe) async {
    try {
      await remoteDataSource.updateRecipe(recipe.toModel());
      return DataSuccess(recipe);
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<ObjectId>> deleteRecipe(ObjectId id) async {
    try {
      await remoteDataSource.deleteRecipe(id);
      return DataSuccess(id);
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<void>> synchronizeRecipes() async {
    return const DataSuccess(null);
  }
}
