import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/core/usecases/usecase.dart';
import 'package:gymprime/features/shared/domain/entities/recipe_entity.dart';
import 'package:gymprime/features/shared/domain/repositories/recipe_repository.dart';
import 'package:objectid/objectid.dart';

class GetAllRecipes implements UseCase<DataState<List<RecipeEntity>>, void> {
  final RecipeRepository repository;

  GetAllRecipes(this.repository);

  @override
  Future<DataState<List<RecipeEntity>>> call(void params) async {
    return await repository.getAllRecipes();
  }
}

class GetMyRecipes implements UseCase<DataState<List<RecipeEntity>>, void> {
  final RecipeRepository repository;

  GetMyRecipes(this.repository);

  @override
  Future<DataState<List<RecipeEntity>>> call(void params) async {
    return await repository.getMyRecipes();
  }
}

class GetRecipe implements UseCase<DataState<RecipeEntity>, ObjectId> {
  final RecipeRepository repository;

  GetRecipe(this.repository);

  @override
  Future<DataState<RecipeEntity>> call(ObjectId id) async {
    return await repository.getRecipe(id);
  }
}

class CreateRecipe implements UseCase<DataState<RecipeEntity>, RecipeEntity> {
  final RecipeRepository repository;

  CreateRecipe(this.repository);

  @override
  Future<DataState<RecipeEntity>> call(RecipeEntity recipe) async {
    return await repository.createRecipe(recipe);
  }
}

class UpdateRecipe implements UseCase<DataState<RecipeEntity>, RecipeEntity> {
  final RecipeRepository repository;

  UpdateRecipe(this.repository);

  @override
  Future<DataState<RecipeEntity>> call(RecipeEntity recipe) async {
    return await repository.updateRecipe(recipe);
  }
}

class DeleteRecipe implements UseCase<DataState<ObjectId>, ObjectId> {
  final RecipeRepository repository;

  DeleteRecipe(this.repository);

  @override
  Future<DataState<ObjectId>> call(ObjectId id) async {
    return await repository.deleteRecipe(id);
  }
}

class SynchronizeRecipes implements UseCase<DataState<void>, void> {
  final RecipeRepository repository;

  SynchronizeRecipes(this.repository);

  @override
  Future<DataState<void>> call(void params) async {
    return await repository.synchronizeRecipes();
  }
}
