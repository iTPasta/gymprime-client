import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/features/shared/data/datasources/local/database/muscle_group_local_db.dart';
import 'package:gymprime/features/shared/data/models/muscle_group_model.dart';
import 'package:objectid/objectid.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MuscleGroupLocalDataSource {
  Future<List<MuscleGroupModel>> getAllMuscleGroups();
  Future<MuscleGroupModel> getMuscleGroup(ObjectId id);
  Future<void> createMuscleGroup(MuscleGroupModel muscleGroup);
  Future<void> updateMuscleGroup(ObjectId id, MuscleGroupModel muscleGroup);
  Future<void> deleteMuscleGroup(ObjectId id);
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
  Future<List<MuscleGroupModel>> getAllMuscleGroups() async {
    return await muscleGroupLocalDB.fetchAll();
  }

  @override
  Future<MuscleGroupModel> getMuscleGroup(ObjectId id) async {
    final List<MuscleGroupModel> muscleGroups =
        await muscleGroupLocalDB.fetchById(id);
    if (muscleGroups.isEmpty) {
      throw NoRowAffectedException();
    } else if (1 < muscleGroups.length) {
      throw MultipleRowsAffectedException();
    } else {
      return muscleGroups.first;
    }
  }

  @override
  Future<void> createMuscleGroup(MuscleGroupModel muscleGroup) async {
    final int id = await muscleGroupLocalDB.insert(muscleGroup);
    if (id == 0) {
      throw NoRowInsertedException();
    }
  }

  @override
  Future<void> updateMuscleGroup(
      ObjectId? id, MuscleGroupModel muscleGroup) async {
    final int rowsUpdated =
        await muscleGroupLocalDB.update(id ?? muscleGroup.id, muscleGroup);
    if (rowsUpdated == 0) {
      throw NoRowAffectedException();
    } else if (1 < rowsUpdated) {
      throw MultipleRowsAffectedException();
    }
  }

  @override
  Future<void> deleteMuscleGroup(ObjectId id) async {
    final int rowDeleted = await muscleGroupLocalDB.delete(id);
    if (rowDeleted == 0) {
      throw NoRowAffectedException();
    } else if (1 < rowDeleted) {
      throw MultipleRowsAffectedException();
    }
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
