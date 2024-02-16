import 'package:gymprime/features/shared/data/datasources/local/database/exercise_local_db.dart';
import 'package:gymprime/features/shared/data/models/exercise_model.dart';
import 'package:objectid/objectid.dart';

abstract class ExerciseLocalDataSource {
  Future<List<ExerciseModel>> getAllExercises();
  Future<ExerciseModel> getExercise(ObjectId id);
  Future<ExerciseModel> createExercise(ExerciseModel exercise);
  Future<ExerciseModel> updateExercise(ObjectId id, ExerciseModel exercise);
  Future<ObjectId> deleteExercise(ObjectId id);
}

class ExerciseLocalDataSourceImpl implements ExerciseLocalDataSource {
  final ExerciseLocalDB _exerciseLocalDB = ExerciseLocalDB();

  @override
  Future<ExerciseModel> createExercise(ExerciseModel exercise) {
    _exerciseLocalDB.insert(exerciseModel: exercise);
    return Future.value(exercise);
  }

  @override
  Future<ObjectId> deleteExercise(ObjectId id) {
    _exerciseLocalDB.delete(id: id);
    return Future.value(id);
  }

  @override
  Future<ExerciseModel> getExercise(ObjectId id) {
    return _exerciseLocalDB.fetchById(id: id);
  }

  @override
  Future<List<ExerciseModel>> getAllExercises() {
    return _exerciseLocalDB.fetchAll();
  }

  @override
  Future<ExerciseModel> updateExercise(ObjectId id, ExerciseModel exercise) {
    _exerciseLocalDB.update(id: id, exerciseModel: exercise);
    return Future.value(exercise);
  }
}
