import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/features/shared/data/datasources/local/database/exercise_local_db.dart';
import 'package:gymprime/features/shared/data/models/exercise_model.dart';
import 'package:objectid/objectid.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ExerciseLocalDataSource {
  Future<List<ExerciseModel>> getAllExercises();
  Future<ExerciseModel> getExercise(ObjectId id);
  Future<void> createExercise(ExerciseModel exercise);
  Future<void> updateExercise(ObjectId id, ExerciseModel exercise);
  Future<void> deleteExercise(ObjectId id);
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
  Future<List<ExerciseModel>> getAllExercises() async {
    return await exerciseLocalDB.fetchAll();
  }

  @override
  Future<ExerciseModel> getExercise(ObjectId id) async {
    final List<ExerciseModel> exercises = await exerciseLocalDB.fetchById(id);
    if (exercises.isEmpty) {
      throw NoRowAffectedException();
    } else if (1 < exercises.length) {
      throw MultipleRowsAffectedException();
    } else {
      return exercises.first;
    }
  }

  @override
  Future<void> createExercise(ExerciseModel exercise) async {
    final int id = await exerciseLocalDB.insert(exercise);
    if (id == 0) {
      throw NoRowInsertedException();
    }
  }

  @override
  Future<void> updateExercise(ObjectId? id, ExerciseModel exercise) async {
    final int rowsUpdated =
        await exerciseLocalDB.update(id ?? exercise.id, exercise);
    if (rowsUpdated == 0) {
      throw NoRowAffectedException();
    } else if (1 < rowsUpdated) {
      throw MultipleRowsAffectedException();
    }
  }

  @override
  Future<void> deleteExercise(ObjectId id) async {
    final int rowDeleted = await exerciseLocalDB.delete(id);
    if (rowDeleted == 0) {
      throw NoRowAffectedException();
    } else if (1 < rowDeleted) {
      throw MultipleRowsAffectedException();
    }
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
