import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/core/usecases/usecase.dart';
import 'package:gymprime/features/shared/domain/entities/exercise_entity.dart';
import 'package:gymprime/features/shared/domain/repositories/exercise_repository.dart';
import 'package:objectid/objectid.dart';

class GetAllExercises
    implements UseCase<DataState<List<ExerciseEntity>>, void> {
  final ExerciseRepository repository;

  GetAllExercises(this.repository);

  @override
  Future<DataState<List<ExerciseEntity>>> call(void params) async {
    return await repository.getAllExercises();
  }
}

class GetExercise implements UseCase<DataState<ExerciseEntity>, ObjectId> {
  final ExerciseRepository repository;

  GetExercise(this.repository);

  @override
  Future<DataState<ExerciseEntity>> call(ObjectId id) async {
    return await repository.getExercise(id);
  }
}

class CreateExercise
    implements UseCase<DataState<ExerciseEntity>, ExerciseEntity> {
  final ExerciseRepository repository;

  CreateExercise(this.repository);

  @override
  Future<DataState<ExerciseEntity>> call(ExerciseEntity exercise) async {
    return await repository.createExercise(exercise);
  }
}

class UpdateExercise
    implements UseCase<DataState<ExerciseEntity>, ExerciseEntity> {
  final ExerciseRepository repository;

  UpdateExercise(this.repository);

  @override
  Future<DataState<ExerciseEntity>> call(ExerciseEntity exercise) async {
    return await repository.updateExercise(exercise);
  }
}

class DeleteExercise implements UseCase<DataState<ObjectId>, ObjectId> {
  final ExerciseRepository repository;

  DeleteExercise(this.repository);

  @override
  Future<DataState<ObjectId>> call(ObjectId id) async {
    return await repository.deleteExercise(id);
  }
}

class SynchronizeExercises implements UseCase<DataState<void>, void> {
  final ExerciseRepository repository;

  SynchronizeExercises(this.repository);

  @override
  Future<DataState<void>> call(void params) async {
    return await repository.synchronizeExercises();
  }
}
