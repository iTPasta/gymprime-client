import 'package:gymprime/features/shared/data/datasources/local/database/exercise_local_db.dart';
import 'package:gymprime/features/shared/data/models/exercise_model.dart';
import 'package:objectid/objectid.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ExerciseLocalDataSource {
  Future<List<ExerciseModel>> getAllExercises();
  Future<ExerciseModel> getExercise(ObjectId id);
  Future<ExerciseModel> createExercise(ExerciseModel exercise);
  Future<ExerciseModel> updateExercise(ObjectId id, ExerciseModel exercise);
  Future<ObjectId> deleteExercise(ObjectId id);
  int? getExercisesLastUpdate();
  void setExercisesLastUpdate(int exercisesLastUpdate);
}

class ExerciseLocalDataSourceImpl implements ExerciseLocalDataSource {
  final ExerciseLocalDB exerciseLocalDB;
  final SharedPreferences sharedPreferences;

  ExerciseLocalDataSourceImpl({
    required this.exerciseLocalDB,
    required this.sharedPreferences,
  });

  @override
  Future<ExerciseModel> createExercise(ExerciseModel exercise) {
    exerciseLocalDB.insert(exerciseModel: exercise);
    return Future.value(exercise);
  }

  @override
  Future<ObjectId> deleteExercise(ObjectId id) {
    exerciseLocalDB.delete(id: id);
    return Future.value(id);
  }

  @override
  Future<ExerciseModel> getExercise(ObjectId id) {
    return exerciseLocalDB.fetchById(id: id);
  }

  @override
  Future<List<ExerciseModel>> getAllExercises() {
    return exerciseLocalDB.fetchAll();
  }

  @override
  Future<ExerciseModel> updateExercise(ObjectId id, ExerciseModel exercise) {
    exerciseLocalDB.update(id: id, exerciseModel: exercise);
    return Future.value(exercise);
  }

  @override
  int? getExercisesLastUpdate() {
    return sharedPreferences.getInt("exercisesLastUpdate");
  }

  @override
  void setExercisesLastUpdate(int exercisesLastUpdate) {
    sharedPreferences.setInt(
      "exercisesLastUpdate",
      exercisesLastUpdate,
    );
  }
}
