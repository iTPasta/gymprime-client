import 'package:gymprime/features/shared/data/datasources/local/database/muscle_local_db.dart';
import 'package:gymprime/features/shared/data/models/muscle_model.dart';
import 'package:objectid/objectid.dart';

abstract class MuscleLocalDataSource {
  Future<List<MuscleModel>> getAllMuscles();
  Future<MuscleModel> getMuscle(ObjectId id);
  Future<MuscleModel> createMuscle(MuscleModel muscle);
  Future<MuscleModel> updateMuscle(ObjectId id, MuscleModel muscle);
  Future<ObjectId> deleteMuscle(ObjectId id);
}

class MuscleLocalDataSourceImpl implements MuscleLocalDataSource {
  final MuscleLocalDB _muscleLocalDB = MuscleLocalDB();

  @override
  Future<MuscleModel> createMuscle(MuscleModel muscle) {
    _muscleLocalDB.insert(muscleModel: muscle);
    return Future.value(muscle);
  }

  @override
  Future<ObjectId> deleteMuscle(ObjectId id) {
    _muscleLocalDB.delete(id: id);
    return Future.value(id);
  }

  @override
  Future<MuscleModel> getMuscle(ObjectId id) {
    return _muscleLocalDB.fetchById(id: id);
  }

  @override
  Future<List<MuscleModel>> getAllMuscles() {
    return _muscleLocalDB.fetchAll();
  }

  @override
  Future<MuscleModel> updateMuscle(ObjectId id, MuscleModel muscle) {
    _muscleLocalDB.update(id: id, muscleModel: muscle);
    return Future.value(muscle);
  }
}
