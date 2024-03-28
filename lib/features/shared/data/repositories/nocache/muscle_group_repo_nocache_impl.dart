import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/core/platform/network_info.dart';
import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/features/shared/data/datasources/remote/muscle_group_remote_datasource.dart';
import 'package:gymprime/features/shared/data/models/muscle_group_model.dart';
import 'package:gymprime/features/shared/domain/entities/muscle_group_entity.dart';
import 'package:gymprime/features/shared/domain/repositories/muscle_group_repository.dart';
import 'package:objectid/objectid.dart';

class MuscleGroupRepositoryNoCacheImpl extends MuscleGroupRepository {
  final MuscleGroupRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MuscleGroupRepositoryNoCacheImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<DataState<List<MuscleGroupEntity>>> getAllMuscleGroups() async {
    try {
      return DataSuccess((await remoteDataSource.getAllMuscleGroups()).$1);
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<MuscleGroupEntity>> getMuscleGroup(ObjectId id) async {
    try {
      return DataSuccess(await remoteDataSource.getMuscleGroup(id));
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<MuscleGroupEntity>> createMuscleGroup(
      MuscleGroupEntity muscleGroup) async {
    try {
      ObjectId muscleGroupId =
          (await remoteDataSource.createMuscleGroup(muscleGroup.toModel())).$1;

      return DataSuccess(MuscleGroupModel(
        id: muscleGroupId,
        names: muscleGroup.names,
        descriptions: muscleGroup.descriptions,
        muscles: muscleGroup.muscles,
      ));
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<MuscleGroupEntity>> updateMuscleGroup(
      MuscleGroupEntity muscleGroup) async {
    try {
      await remoteDataSource.updateMuscleGroup(muscleGroup.toModel());
      return DataSuccess(muscleGroup);
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<ObjectId>> deleteMuscleGroup(ObjectId id) async {
    try {
      await remoteDataSource.deleteMuscleGroup(id);
      return DataSuccess(id);
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<void>> synchronizeMuscleGroups() async {
    return const DataSuccess(null);
  }
}
