import 'package:gymprime/features/shared/data/datasources/local/database/meal_local_db.dart';
import 'package:gymprime/features/shared/data/models/meal_model.dart';
import 'package:objectid/objectid.dart';

abstract class MealLocalDataSource {
  Future<List<MealModel>> getMyMeals();
  Future<MealModel> getMeal(ObjectId id);
  Future<MealModel> createMeal(MealModel meal);
  Future<MealModel> updateMeal(ObjectId id, MealModel meal);
  Future<ObjectId> deleteMeal(ObjectId id);
}

class MealLocalDataSourceImpl implements MealLocalDataSource {
  final MealLocalDB _mealLocalDB = MealLocalDB();

  @override
  Future<MealModel> createMeal(MealModel meal) {
    _mealLocalDB.insert(mealModel: meal);
    return Future.value(meal);
  }

  @override
  Future<ObjectId> deleteMeal(ObjectId id) {
    _mealLocalDB.delete(id: id);
    return Future.value(id);
  }

  @override
  Future<MealModel> getMeal(ObjectId id) {
    return _mealLocalDB.fetchById(id: id);
  }

  @override
  Future<List<MealModel>> getMyMeals() {
    return _mealLocalDB.fetchAll();
  }

  @override
  Future<MealModel> updateMeal(ObjectId id, MealModel meal) {
    _mealLocalDB.update(id: id, mealModel: meal);
    return Future.value(meal);
  }
}
