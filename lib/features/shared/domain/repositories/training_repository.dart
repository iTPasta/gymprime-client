import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/features/shared/domain/entities/training_entity.dart';
import 'package:objectid/objectid.dart';

abstract class TrainingRepository {
  Future<DataState<List<TrainingEntity>>> getAllTrainings();
  Future<DataState<List<TrainingEntity>>> getMyTrainings();
  Future<DataState<TrainingEntity>> getTraining(ObjectId id);
  Future<DataState<TrainingEntity>> createTraining(TrainingEntity training);
  Future<DataState<TrainingEntity>> updateTraining(TrainingEntity training);
  Future<DataState<ObjectId>> deleteTraining(ObjectId id);
  Future<DataState<void>> synchronizeTrainings();
}
