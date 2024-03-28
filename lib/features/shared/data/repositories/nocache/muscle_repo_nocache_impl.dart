import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/core/platform/network_info.dart';
import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/features/shared/data/datasources/remote/muscle_remote_datasource.dart';
import 'package:gymprime/features/shared/data/models/muscle_model.dart';
import 'package:gymprime/features/shared/domain/entities/muscle_entity.dart';
import 'package:gymprime/features/shared/domain/repositories/muscle_repository.dart';
import 'package:objectid/objectid.dart';

class MuscleRepositoryNoCacheImpl extends MuscleRepository {
  final MuscleRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MuscleRepositoryNoCacheImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<DataState<List<MuscleEntity>>> getAllMuscles() async {
    try {
      return DataSuccess((await remoteDataSource.getAllMuscles()).$1);
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<MuscleEntity>> getMuscle(ObjectId id) async {
    try {
      return DataSuccess(await remoteDataSource.getMuscle(id));
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<MuscleEntity>> createMuscle(MuscleEntity muscle) async {
    try {
      ObjectId muscleId =
          (await remoteDataSource.createMuscle(muscle.toModel())).$1;

      return DataSuccess(MuscleModel(
        id: muscleId,
        names: muscle.names,
        descriptions: muscle.descriptions,
        exercises: muscle.exercises,
        muscleGroup: muscle.muscleGroup,
      ));
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<MuscleEntity>> updateMuscle(MuscleEntity muscle) async {
    try {
      await remoteDataSource.updateMuscle(muscle.toModel());
      return DataSuccess(muscle);
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<ObjectId>> deleteMuscle(ObjectId id) async {
    try {
      await remoteDataSource.deleteMuscle(id);
      return DataSuccess(id);
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<void>> synchronizeMuscles() async {
    return const DataSuccess(null);
  }
}
