import 'package:gymprime/features/shared/data/datasources/local/database/training_local_db.dart';
import 'package:gymprime/features/shared/data/models/training_model.dart';
import 'package:objectid/objectid.dart';

abstract class TrainingLocalDataSource {
  Future<List<TrainingModel>> getMyTrainings();
  Future<TrainingModel> getTraining(ObjectId id);
  Future<TrainingModel> createTraining(TrainingModel training);
  Future<TrainingModel> updateTraining(ObjectId id, TrainingModel training);
  Future<ObjectId> deleteTraining(ObjectId id);
}

class TrainingLocalDataSourceImpl implements TrainingLocalDataSource {
  final TrainingLocalDB _trainingLocalDB = TrainingLocalDB();

  @override
  Future<TrainingModel> createTraining(TrainingModel training) {
    _trainingLocalDB.insert(trainingModel: training);
    return Future.value(training);
  }

  @override
  Future<ObjectId> deleteTraining(ObjectId id) {
    _trainingLocalDB.delete(id: id);
    return Future.value(id);
  }

  @override
  Future<TrainingModel> getTraining(ObjectId id) {
    return _trainingLocalDB.fetchById(id: id);
  }

  @override
  Future<List<TrainingModel>> getMyTrainings() {
    return _trainingLocalDB.fetchAll();
  }

  @override
  Future<TrainingModel> updateTraining(ObjectId id, TrainingModel training) {
    _trainingLocalDB.update(id: id, trainingModel: training);
    return Future.value(training);
  }
}
