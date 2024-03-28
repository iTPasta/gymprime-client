import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/core/usecases/usecase.dart';
import 'package:gymprime/features/shared/domain/entities/meal_entity.dart';
import 'package:gymprime/features/shared/domain/repositories/meal_repository.dart';
import 'package:objectid/objectid.dart';

class GetAllMeals implements UseCase<DataState<List<MealEntity>>, void> {
  final MealRepository repository;

  GetAllMeals(this.repository);

  @override
  Future<DataState<List<MealEntity>>> call(void params) async {
    return await repository.getAllMeals();
  }
}

class GetMyMeals implements UseCase<DataState<List<MealEntity>>, void> {
  final MealRepository repository;

  GetMyMeals(this.repository);

  @override
  Future<DataState<List<MealEntity>>> call(void params) async {
    return await repository.getMyMeals();
  }
}

class GetMeal implements UseCase<DataState<MealEntity>, ObjectId> {
  final MealRepository repository;

  GetMeal(this.repository);

  @override
  Future<DataState<MealEntity>> call(ObjectId id) async {
    return await repository.getMeal(id);
  }
}

class CreateMeal implements UseCase<DataState<MealEntity>, MealEntity> {
  final MealRepository repository;

  CreateMeal(this.repository);

  @override
  Future<DataState<MealEntity>> call(MealEntity meal) async {
    return await repository.createMeal(meal);
  }
}

class UpdateMeal implements UseCase<DataState<MealEntity>, MealEntity> {
  final MealRepository repository;

  UpdateMeal(this.repository);

  @override
  Future<DataState<MealEntity>> call(MealEntity meal) async {
    return await repository.updateMeal(meal);
  }
}

class DeleteMeal implements UseCase<DataState<ObjectId>, ObjectId> {
  final MealRepository repository;

  DeleteMeal(this.repository);

  @override
  Future<DataState<ObjectId>> call(ObjectId id) async {
    return await repository.deleteMeal(id);
  }
}

class SynchronizeMeals implements UseCase<DataState<void>, void> {
  final MealRepository repository;

  SynchronizeMeals(this.repository);

  @override
  Future<DataState<void>> call(void params) async {
    return await repository.synchronizeMeals();
  }
}
