import 'package:gymprime/features/shared/data/datasources/local/database/muscle_group_local_db.dart';
import 'package:gymprime/features/shared/data/models/muscle_group_model.dart';
import 'package:objectid/objectid.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MuscleGroupLocalDataSource {
  Future<List<MuscleGroupModel>> getAllMuscleGroups();
  Future<MuscleGroupModel> getMuscleGroup(ObjectId id);
  Future<MuscleGroupModel> createMuscleGroup(MuscleGroupModel muscleGroup);
  Future<MuscleGroupModel> updateMuscleGroup(
      ObjectId id, MuscleGroupModel muscleGroup);
  Future<ObjectId> deleteMuscleGroup(ObjectId id);
  int? getMuscleGroupsLastUpdate();
  void setMuscleGroupsLastUpdate(int muscleGroupsLastUpdate);
}

class MuscleGroupLocalDataSourceImpl implements MuscleGroupLocalDataSource {
  final MuscleGroupLocalDB muscleGroupLocalDB;
  final SharedPreferences sharedPreferences;

  MuscleGroupLocalDataSourceImpl({
    required this.muscleGroupLocalDB,
    required this.sharedPreferences,
  });

  @override
  Future<MuscleGroupModel> createMuscleGroup(MuscleGroupModel muscleGroup) {
    muscleGroupLocalDB.insert(muscleGroupModel: muscleGroup);
    return Future.value(muscleGroup);
  }

  @override
  Future<ObjectId> deleteMuscleGroup(ObjectId id) {
    muscleGroupLocalDB.delete(id: id);
    return Future.value(id);
  }

  @override
  Future<MuscleGroupModel> getMuscleGroup(ObjectId id) {
    return muscleGroupLocalDB.fetchById(id: id);
  }

  @override
  Future<List<MuscleGroupModel>> getAllMuscleGroups() {
    return muscleGroupLocalDB.fetchAll();
  }

  @override
  Future<MuscleGroupModel> updateMuscleGroup(
    ObjectId id,
    MuscleGroupModel muscleGroup,
  ) {
    muscleGroupLocalDB.update(id: id, muscleGroupModel: muscleGroup);
    return Future.value(muscleGroup);
  }

  @override
  int? getMuscleGroupsLastUpdate() {
    return sharedPreferences.getInt("muscleGroupsLastUpdate");
  }

  @override
  void setMuscleGroupsLastUpdate(int muscleGroupsLastUpdate) {
    sharedPreferences.setInt("muscleGroupsLastUpdate", muscleGroupsLastUpdate);
  }
}
