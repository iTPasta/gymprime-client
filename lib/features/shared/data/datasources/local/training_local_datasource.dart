import 'package:gymprime/features/shared/data/datasources/local/database/training_local_db.dart';
import 'package:gymprime/features/shared/data/models/training_model.dart';
import 'package:objectid/objectid.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TrainingLocalDataSource {
  Future<List<TrainingModel>> getMyTrainings();
  Future<TrainingModel> getTraining(ObjectId id);
  Future<TrainingModel> createTraining(TrainingModel training);
  Future<TrainingModel> updateTraining(ObjectId id, TrainingModel training);
  Future<ObjectId> deleteTraining(ObjectId id);
  int? getTrainingsLastUpdate();
  void setTrainingsLastUpdate(int trainingsLastUpdate);
}

class TrainingLocalDataSourceImpl implements TrainingLocalDataSource {
  final TrainingLocalDB trainingLocalDB;
  final SharedPreferences sharedPreferences;

  TrainingLocalDataSourceImpl({
    required this.trainingLocalDB,
    required this.sharedPreferences,
  });

  @override
  Future<TrainingModel> createTraining(TrainingModel training) {
    trainingLocalDB.insert(trainingModel: training);
    return Future.value(training);
  }

  @override
  Future<ObjectId> deleteTraining(ObjectId id) {
    trainingLocalDB.delete(id: id);
    return Future.value(id);
  }

  @override
  Future<TrainingModel> getTraining(ObjectId id) {
    return trainingLocalDB.fetchById(id: id);
  }

  @override
  Future<List<TrainingModel>> getMyTrainings() {
    return trainingLocalDB.fetchAll();
  }

  @override
  Future<TrainingModel> updateTraining(ObjectId id, TrainingModel training) {
    trainingLocalDB.update(id: id, trainingModel: training);
    return Future.value(training);
  }

  @override
  int? getTrainingsLastUpdate() {
    return sharedPreferences.getInt("trainingsLastUpdate");
  }

  @override
  void setTrainingsLastUpdate(int trainingsLastUpdate) {
    sharedPreferences.setInt("trainingsLastUpdate", trainingsLastUpdate);
  }
}
