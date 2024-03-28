import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/features/shared/data/datasources/local/database/meal_local_db.dart';
import 'package:gymprime/features/shared/data/models/meal_model.dart';
import 'package:objectid/objectid.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MealLocalDataSource {
  Future<List<MealModel>> getMyMeals();
  Future<MealModel> getMeal(ObjectId id);
  Future<void> createMeal(MealModel meal);
  Future<void> updateMeal(ObjectId id, MealModel meal);
  Future<void> deleteMeal(ObjectId id);
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
  Future<List<MealModel>> getMyMeals() async {
    return await mealLocalDB.fetchAll();
  }

  @override
  Future<MealModel> getMeal(ObjectId id) async {
    final List<MealModel> meals = await mealLocalDB.fetchById(id);
    if (meals.isEmpty) {
      throw NoRowAffectedException();
    } else if (1 < meals.length) {
      throw MultipleRowsAffectedException();
    } else {
      return meals.first;
    }
  }

  @override
  Future<void> createMeal(MealModel meal) async {
    final int id = await mealLocalDB.insert(meal);
    if (id == 0) {
      throw NoRowInsertedException();
    }
  }

  @override
  Future<void> updateMeal(ObjectId? id, MealModel meal) async {
    final int rowsUpdated = await mealLocalDB.update(id ?? meal.id, meal);
    if (rowsUpdated == 0) {
      throw NoRowAffectedException();
    } else if (1 < rowsUpdated) {
      throw MultipleRowsAffectedException();
    }
  }

  @override
  Future<void> deleteMeal(ObjectId id) async {
    final int rowDeleted = await mealLocalDB.delete(id);
    if (rowDeleted == 0) {
      throw NoRowAffectedException();
    } else if (1 < rowDeleted) {
      throw MultipleRowsAffectedException();
    }
  }

  @override
  int? getMealsLastUpdate() {
    throw UnimplementedError();
  }

  @override
  void setMealsLastUpdate(int mealsLastUpdate) async {
    sharedPreferences.setInt(
      "mealsLastUpdate",
      mealsLastUpdate,
    );
  }
}
