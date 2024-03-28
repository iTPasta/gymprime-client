import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/core/usecases/usecase.dart';
import 'package:gymprime/features/shared/domain/entities/muscle_entity.dart';
import 'package:gymprime/features/shared/domain/repositories/muscle_repository.dart';
import 'package:objectid/objectid.dart';

class GetAllMuscles implements UseCase<DataState<List<MuscleEntity>>, void> {
  final MuscleRepository repository;

  GetAllMuscles(this.repository);

  @override
  Future<DataState<List<MuscleEntity>>> call(void params) async {
    return await repository.getAllMuscles();
  }
}

class GetMuscle implements UseCase<DataState<MuscleEntity>, ObjectId> {
  final MuscleRepository repository;

  GetMuscle(this.repository);

  @override
  Future<DataState<MuscleEntity>> call(ObjectId id) async {
    return await repository.getMuscle(id);
  }
}

class CreateMuscle implements UseCase<DataState<MuscleEntity>, MuscleEntity> {
  final MuscleRepository repository;

  CreateMuscle(this.repository);

  @override
  Future<DataState<MuscleEntity>> call(MuscleEntity muscle) async {
    return await repository.createMuscle(muscle);
  }
}

class UpdateMuscle implements UseCase<DataState<MuscleEntity>, MuscleEntity> {
  final MuscleRepository repository;

  UpdateMuscle(this.repository);

  @override
  Future<DataState<MuscleEntity>> call(MuscleEntity muscle) async {
    return await repository.updateMuscle(muscle);
  }
}

class DeleteMuscle implements UseCase<DataState<ObjectId>, ObjectId> {
  final MuscleRepository repository;

  DeleteMuscle(this.repository);

  @override
  Future<DataState<ObjectId>> call(ObjectId id) async {
    return await repository.deleteMuscle(id);
  }
}

class SynchronizeMuscles implements UseCase<DataState<void>, void> {
  final MuscleRepository repository;

  SynchronizeMuscles(this.repository);

  @override
  Future<DataState<void>> call(void params) async {
    return await repository.synchronizeMuscles();
  }
}
