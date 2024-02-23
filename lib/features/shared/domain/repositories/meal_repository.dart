import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/features/shared/domain/entities/meal_entity.dart';
import 'package:objectid/objectid.dart';

abstract class MealRepository {
  Future<DataState<List<MealEntity>>> getAllMeals();
  Future<DataState<List<MealEntity>>> getMyMeals();
  Future<DataState<MealEntity>> getMeal(ObjectId id);
  Future<DataState<MealEntity>> createMeal(MealEntity mealEntity);
  Future<DataState<MealEntity>> updateMeal(MealEntity mealEntity);
  Future<DataState<ObjectId>> deleteMeal(ObjectId id);
  Future<DataState<void>> syncMyMeals();
}
