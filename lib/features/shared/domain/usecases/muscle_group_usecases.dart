import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/core/usecases/usecase.dart';
import 'package:gymprime/features/shared/domain/entities/muscle_group_entity.dart';
import 'package:gymprime/features/shared/domain/repositories/muscle_group_repository.dart';
import 'package:objectid/objectid.dart';

class GetAllMuscleGroups
    implements UseCase<DataState<List<MuscleGroupEntity>>, void> {
  final MuscleGroupRepository repository;

  GetAllMuscleGroups(this.repository);

  @override
  Future<DataState<List<MuscleGroupEntity>>> call(void params) async {
    return await repository.getAllMuscleGroups();
  }
}

class GetMuscleGroup
    implements UseCase<DataState<MuscleGroupEntity>, ObjectId> {
  final MuscleGroupRepository repository;

  GetMuscleGroup(this.repository);

  @override
  Future<DataState<MuscleGroupEntity>> call(ObjectId id) async {
    return await repository.getMuscleGroup(id);
  }
}

class CreateMuscleGroup
    implements UseCase<DataState<MuscleGroupEntity>, MuscleGroupEntity> {
  final MuscleGroupRepository repository;

  CreateMuscleGroup(this.repository);

  @override
  Future<DataState<MuscleGroupEntity>> call(
      MuscleGroupEntity muscleGroup) async {
    return await repository.createMuscleGroup(muscleGroup);
  }
}

class UpdateMuscleGroup
    implements UseCase<DataState<MuscleGroupEntity>, MuscleGroupEntity> {
  final MuscleGroupRepository repository;

  UpdateMuscleGroup(this.repository);

  @override
  Future<DataState<MuscleGroupEntity>> call(
      MuscleGroupEntity muscleGroup) async {
    return await repository.updateMuscleGroup(muscleGroup);
  }
}

class DeleteMuscleGroup implements UseCase<DataState<ObjectId>, ObjectId> {
  final MuscleGroupRepository repository;

  DeleteMuscleGroup(this.repository);

  @override
  Future<DataState<ObjectId>> call(ObjectId id) async {
    return await repository.deleteMuscleGroup(id);
  }
}

class SynchronizeMuscleGroups implements UseCase<DataState<void>, void> {
  final MuscleGroupRepository repository;

  SynchronizeMuscleGroups(this.repository);

  @override
  Future<DataState<void>> call(void params) async {
    return await repository.synchronizeMuscleGroups();
  }
}
