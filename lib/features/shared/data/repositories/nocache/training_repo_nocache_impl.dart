import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/core/platform/network_info.dart';
import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/features/shared/data/datasources/remote/training_remote_datasource.dart';
import 'package:gymprime/features/shared/data/models/training_model.dart';
import 'package:gymprime/features/shared/domain/entities/training_entity.dart';
import 'package:gymprime/features/shared/domain/repositories/training_repository.dart';
import 'package:objectid/objectid.dart';

class TrainingRepositoryNoCacheImpl extends TrainingRepository {
  final TrainingRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TrainingRepositoryNoCacheImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<DataState<List<TrainingEntity>>> getAllTrainings() async {
    try {
      return DataSuccess(await remoteDataSource.getAllTrainings());
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<List<TrainingEntity>>> getMyTrainings() async {
    try {
      return DataSuccess((await remoteDataSource.getMyTrainings()).$1);
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<TrainingEntity>> getTraining(ObjectId id) async {
    try {
      return DataSuccess(await remoteDataSource.getTraining(id));
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<TrainingEntity>> createTraining(
      TrainingEntity training) async {
    try {
      ObjectId trainingId =
          (await remoteDataSource.createTraining(training.toModel())).$1;

      return DataSuccess(TrainingModel(
        id: trainingId,
        name: training.name,
        sets: training.sets,
        notes: training.notes,
      ));
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<TrainingEntity>> updateTraining(
      TrainingEntity training) async {
    try {
      await remoteDataSource.updateTraining(training.toModel());
      return DataSuccess(training);
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<ObjectId>> deleteTraining(ObjectId id) async {
    try {
      await remoteDataSource.deleteTraining(id);
      return DataSuccess(id);
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<void>> synchronizeTrainings() async {
    return const DataSuccess(null);
  }
}
