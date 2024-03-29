import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/features/shared/domain/entities/exercise_entity.dart';
import 'package:objectid/objectid.dart';

abstract class ExerciseRepository {
  Future<DataState<List<ExerciseEntity>>> getAllExercises();
  Future<DataState<ExerciseEntity>> getExercise(ObjectId id);
  Future<DataState<ExerciseEntity>> createExercise(ExerciseEntity exercise);
  Future<DataState<ExerciseEntity>> updateExercise(ExerciseEntity exercise);
  Future<DataState<ObjectId>> deleteExercise(ObjectId id);
  Future<DataState<void>> synchronizeExercises();
}
