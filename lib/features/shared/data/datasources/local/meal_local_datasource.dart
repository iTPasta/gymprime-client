import 'package:gymprime/features/shared/data/datasources/local/database/meal_local_db.dart';
import 'package:gymprime/features/shared/data/models/meal_model.dart';
import 'package:objectid/objectid.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MealLocalDataSource {
  Future<List<MealModel>> getMyMeals();
  Future<MealModel> getMeal(ObjectId id);
  Future<MealModel> createMeal(MealModel meal);
  Future<MealModel> updateMeal(ObjectId id, MealModel meal);
  Future<ObjectId> deleteMeal(ObjectId id);
  int? getMealsLastUpdate();
  void setMealsLastUpdate(int mealsLastUpdate);
}

class MealLocalDataSourceImpl implements MealLocalDataSource {
  final MealLocalDB mealLocalDB;
  final SharedPreferences sharedPreferences;

  MealLocalDataSourceImpl({
    required this.mealLocalDB,
    required this.sharedPreferences,
  });

  @override
  Future<MealModel> createMeal(MealModel meal) {
    mealLocalDB.insert(mealModel: meal);
    return Future.value(meal);
  }

  @override
  Future<ObjectId> deleteMeal(ObjectId id) {
    mealLocalDB.delete(id: id);
    return Future.value(id);
  }

  @override
  Future<MealModel> getMeal(ObjectId id) {
    return mealLocalDB.fetchById(id: id);
  }

  @override
  Future<List<MealModel>> getMyMeals() {
    return mealLocalDB.fetchAll();
  }

  @override
  Future<MealModel> updateMeal(ObjectId id, MealModel meal) {
    mealLocalDB.update(id: id, mealModel: meal);
    return Future.value(meal);
  }

  @override
  int? getMealsLastUpdate() {
    // TODO: implement getMealsLastUpdate
    throw UnimplementedError();
  }

  @override
  void setMealsLastUpdate(int mealsLastUpdate) {
    sharedPreferences.setInt(
      "mealsLastUpdate",
      mealsLastUpdate,
    );
  }
}
