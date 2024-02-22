import 'package:gymprime/features/shared/data/datasources/local/database/muscle_local_db.dart';
import 'package:gymprime/features/shared/data/models/muscle_model.dart';
import 'package:objectid/objectid.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MuscleLocalDataSource {
  Future<List<MuscleModel>> getAllMuscles();
  Future<MuscleModel> getMuscle(ObjectId id);
  Future<MuscleModel> createMuscle(MuscleModel muscle);
  Future<MuscleModel> updateMuscle(ObjectId id, MuscleModel muscle);
  Future<ObjectId> deleteMuscle(ObjectId id);
  int? getMusclesLastUpdate();
  void setMusclesLastUpdate(int musclesLastUpdate);
}

class MuscleLocalDataSourceImpl implements MuscleLocalDataSource {
  final MuscleLocalDB muscleLocalDB;
  final SharedPreferences sharedPreferences;

  MuscleLocalDataSourceImpl({
    required this.muscleLocalDB,
    required this.sharedPreferences,
  });

  @override
  Future<MuscleModel> createMuscle(MuscleModel muscle) {
    muscleLocalDB.insert(muscleModel: muscle);
    return Future.value(muscle);
  }

  @override
  Future<ObjectId> deleteMuscle(ObjectId id) {
    muscleLocalDB.delete(id: id);
    return Future.value(id);
  }

  @override
  Future<MuscleModel> getMuscle(ObjectId id) {
    return muscleLocalDB.fetchById(id: id);
  }

  @override
  Future<List<MuscleModel>> getAllMuscles() {
    return muscleLocalDB.fetchAll();
  }

  @override
  Future<MuscleModel> updateMuscle(ObjectId id, MuscleModel muscle) {
    muscleLocalDB.update(id: id, muscleModel: muscle);
    return Future.value(muscle);
  }

  @override
  int? getMusclesLastUpdate() {
    return sharedPreferences.getInt("musclesLastUpdate");
  }

  @override
  void setMusclesLastUpdate(int musclesLastUpdate) {
    sharedPreferences.setInt("musclesLastUpdate", musclesLastUpdate);
  }
}
