import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/features/shared/data/datasources/local/database/training_local_db.dart';
import 'package:gymprime/features/shared/data/models/training_model.dart';
import 'package:objectid/objectid.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TrainingLocalDataSource {
  Future<List<TrainingModel>> getMyTrainings();
  Future<TrainingModel> getTraining(ObjectId id);
  Future<void> createTraining(TrainingModel training);
  Future<void> updateTraining(ObjectId id, TrainingModel training);
  Future<void> deleteTraining(ObjectId id);
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
  Future<List<TrainingModel>> getMyTrainings() async {
    return await trainingLocalDB.fetchAll();
  }

  @override
  Future<TrainingModel> getTraining(ObjectId id) async {
    final List<TrainingModel> trainings = await trainingLocalDB.fetchById(id);
    if (trainings.isEmpty) {
      throw NoRowAffectedException();
    } else if (1 < trainings.length) {
      throw MultipleRowsAffectedException();
    } else {
      return trainings.first;
    }
  }

  @override
  Future<void> createTraining(TrainingModel training) async {
    final int id = await trainingLocalDB.insert(training);
    if (id == 0) {
      throw NoRowInsertedException();
    }
  }

  @override
  Future<void> updateTraining(ObjectId? id, TrainingModel training) async {
    final int rowsUpdated =
        await trainingLocalDB.update(id ?? training.id, training);
    if (rowsUpdated == 0) {
      throw NoRowAffectedException();
    } else if (1 < rowsUpdated) {
      throw MultipleRowsAffectedException();
    }
  }

  @override
  Future<void> deleteTraining(ObjectId id) async {
    final int rowDeleted = await trainingLocalDB.delete(id);
    if (rowDeleted == 0) {
      throw NoRowAffectedException();
    } else if (1 < rowDeleted) {
      throw MultipleRowsAffectedException();
    }
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
