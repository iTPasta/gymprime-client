import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/core/platform/network_info.dart';
import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/features/shared/data/datasources/remote/exercise_remote_datasource.dart';
import 'package:gymprime/features/shared/data/models/exercise_model.dart';
import 'package:gymprime/features/shared/domain/entities/exercise_entity.dart';
import 'package:gymprime/features/shared/domain/repositories/exercise_repository.dart';
import 'package:objectid/objectid.dart';

class ExerciseRepositoryNoCacheImpl extends ExerciseRepository {
  final ExerciseRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ExerciseRepositoryNoCacheImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<DataState<List<ExerciseEntity>>> getAllExercises() async {
    try {
      return DataSuccess((await remoteDataSource.getAllExercises()).$1);
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<ExerciseEntity>> getExercise(ObjectId id) async {
    try {
      return DataSuccess(await remoteDataSource.getExercise(id));
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<ExerciseEntity>> createExercise(
      ExerciseEntity exercise) async {
    try {
      ObjectId exerciseId =
          (await remoteDataSource.createExercise(exercise.toModel())).$1;

      return DataSuccess(ExerciseModel(
        id: exerciseId,
        names: exercise.names,
        descriptions: exercise.descriptions,
        muscles: exercise.muscles,
        muscleGroup: exercise.muscleGroup,
      ));
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<ExerciseEntity>> updateExercise(
      ExerciseEntity exercise) async {
    try {
      await remoteDataSource.updateExercise(exercise.toModel());
      return DataSuccess(exercise);
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<ObjectId>> deleteExercise(ObjectId id) async {
    try {
      await remoteDataSource.deleteExercise(id);
      return DataSuccess(id);
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<void>> synchronizeExercises() async {
    return const DataSuccess(null);
  }
}
