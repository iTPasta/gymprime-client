import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/core/platform/network_info.dart';
import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/features/shared/data/datasources/remote/meal_remote_datasource.dart';
import 'package:gymprime/features/shared/data/models/meal_model.dart';
import 'package:gymprime/features/shared/domain/entities/meal_entity.dart';
import 'package:gymprime/features/shared/domain/repositories/meal_repository.dart';
import 'package:objectid/objectid.dart';

class MealRepositoryNoCacheImpl extends MealRepository {
  final MealRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MealRepositoryNoCacheImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<DataState<List<MealEntity>>> getAllMeals() async {
    try {
      return DataSuccess(await remoteDataSource.getAllMeals());
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<List<MealEntity>>> getMyMeals() async {
    try {
      return DataSuccess((await remoteDataSource.getMyMeals()).$1);
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<MealEntity>> getMeal(ObjectId id) async {
    try {
      return DataSuccess(await remoteDataSource.getMeal(id));
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<MealEntity>> createMeal(MealEntity meal) async {
    try {
      ObjectId mealId = (await remoteDataSource.createMeal(meal.toModel())).$1;

      return DataSuccess(MealModel(
        id: mealId,
        name: meal.name,
        description: meal.description,
        recipes: meal.recipes,
        aliments: meal.aliments,
      ));
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<MealEntity>> updateMeal(MealEntity meal) async {
    try {
      await remoteDataSource.updateMeal(meal.toModel());
      return DataSuccess(meal);
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<ObjectId>> deleteMeal(ObjectId id) async {
    try {
      await remoteDataSource.deleteMeal(id);
      return DataSuccess(id);
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<void>> synchronizeMeals() async {
    return const DataSuccess(null);
  }
}
