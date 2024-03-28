import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/core/usecases/usecase.dart';
import 'package:gymprime/features/shared/domain/entities/diet_entity.dart';
import 'package:gymprime/features/shared/domain/repositories/diet_repository.dart';
import 'package:objectid/objectid.dart';

class GetAllDiets implements UseCase<DataState<List<DietEntity>>, void> {
  final DietRepository repository;

  GetAllDiets(this.repository);

  @override
  Future<DataState<List<DietEntity>>> call(void params) async {
    return await repository.getAllDiets();
  }
}

class GetMyDiets implements UseCase<DataState<List<DietEntity>>, void> {
  final DietRepository repository;

  GetMyDiets(this.repository);

  @override
  Future<DataState<List<DietEntity>>> call(void params) async {
    return await repository.getMyDiets();
  }
}

class GetDiet implements UseCase<DataState<DietEntity>, ObjectId> {
  final DietRepository repository;

  GetDiet(this.repository);

  @override
  Future<DataState<DietEntity>> call(ObjectId id) async {
    return await repository.getDiet(id);
  }
}

class CreateDiet implements UseCase<DataState<DietEntity>, DietEntity> {
  final DietRepository repository;

  CreateDiet(this.repository);

  @override
  Future<DataState<DietEntity>> call(DietEntity diet) async {
    return await repository.createDiet(diet);
  }
}

class UpdateDiet implements UseCase<DataState<DietEntity>, DietEntity> {
  final DietRepository repository;

  UpdateDiet(this.repository);

  @override
  Future<DataState<DietEntity>> call(DietEntity diet) async {
    return await repository.updateDiet(diet);
  }
}

class DeleteDiet implements UseCase<DataState<ObjectId>, ObjectId> {
  final DietRepository repository;

  DeleteDiet(this.repository);

  @override
  Future<DataState<ObjectId>> call(ObjectId id) async {
    return await repository.deleteDiet(id);
  }
}

class SynchronizeDiets implements UseCase<DataState<void>, void> {
  final DietRepository repository;

  SynchronizeDiets(this.repository);

  @override
  Future<DataState<void>> call(void params) async {
    return await repository.synchronizeDiets();
  }
}
