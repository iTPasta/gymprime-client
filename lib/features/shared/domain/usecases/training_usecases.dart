import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/core/usecases/usecase.dart';
import 'package:gymprime/features/shared/domain/entities/training_entity.dart';
import 'package:gymprime/features/shared/domain/repositories/training_repository.dart';
import 'package:objectid/objectid.dart';

class GetAllTrainings
    implements UseCase<DataState<List<TrainingEntity>>, void> {
  final TrainingRepository repository;

  GetAllTrainings(this.repository);

  @override
  Future<DataState<List<TrainingEntity>>> call(void params) async {
    return await repository.getAllTrainings();
  }
}

class GetMyTrainings implements UseCase<DataState<List<TrainingEntity>>, void> {
  final TrainingRepository repository;

  GetMyTrainings(this.repository);

  @override
  Future<DataState<List<TrainingEntity>>> call(void params) async {
    return await repository.getMyTrainings();
  }
}

class GetTraining implements UseCase<DataState<TrainingEntity>, ObjectId> {
  final TrainingRepository repository;

  GetTraining(this.repository);

  @override
  Future<DataState<TrainingEntity>> call(ObjectId id) async {
    return await repository.getTraining(id);
  }
}

class CreateTraining
    implements UseCase<DataState<TrainingEntity>, TrainingEntity> {
  final TrainingRepository repository;

  CreateTraining(this.repository);

  @override
  Future<DataState<TrainingEntity>> call(TrainingEntity training) async {
    return await repository.createTraining(training);
  }
}

class UpdateTraining
    implements UseCase<DataState<TrainingEntity>, TrainingEntity> {
  final TrainingRepository repository;

  UpdateTraining(this.repository);

  @override
  Future<DataState<TrainingEntity>> call(TrainingEntity training) async {
    return await repository.updateTraining(training);
  }
}

class DeleteTraining implements UseCase<DataState<ObjectId>, ObjectId> {
  final TrainingRepository repository;

  DeleteTraining(this.repository);

  @override
  Future<DataState<ObjectId>> call(ObjectId id) async {
    return await repository.deleteTraining(id);
  }
}

class SynchronizeTrainings implements UseCase<DataState<void>, void> {
  final TrainingRepository repository;

  SynchronizeTrainings(this.repository);

  @override
  Future<DataState<void>> call(void params) async {
    return await repository.synchronizeTrainings();
  }
}
