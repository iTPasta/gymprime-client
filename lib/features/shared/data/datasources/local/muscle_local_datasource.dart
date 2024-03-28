import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/features/shared/data/datasources/local/database/muscle_local_db.dart';
import 'package:gymprime/features/shared/data/models/muscle_model.dart';
import 'package:objectid/objectid.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MuscleLocalDataSource {
  Future<List<MuscleModel>> getAllMuscles();
  Future<MuscleModel> getMuscle(ObjectId id);
  Future<void> createMuscle(MuscleModel muscle);
  Future<void> updateMuscle(ObjectId id, MuscleModel muscle);
  Future<void> deleteMuscle(ObjectId id);
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
  Future<List<MuscleModel>> getAllMuscles() async {
    return await muscleLocalDB.fetchAll();
  }

  @override
  Future<MuscleModel> getMuscle(ObjectId id) async {
    final List<MuscleModel> muscles = await muscleLocalDB.fetchById(id);
    if (muscles.isEmpty) {
      throw NoRowAffectedException();
    } else if (1 < muscles.length) {
      throw MultipleRowsAffectedException();
    } else {
      return muscles.first;
    }
  }

  @override
  Future<void> createMuscle(MuscleModel muscle) async {
    final int id = await muscleLocalDB.insert(muscle);
    if (id == 0) {
      throw NoRowInsertedException();
    }
  }

  @override
  Future<void> updateMuscle(ObjectId? id, MuscleModel muscle) async {
    final int rowsUpdated = await muscleLocalDB.update(id ?? muscle.id, muscle);
    if (rowsUpdated == 0) {
      throw NoRowAffectedException();
    } else if (1 < rowsUpdated) {
      throw MultipleRowsAffectedException();
    }
  }

  @override
  Future<void> deleteMuscle(ObjectId id) async {
    final int rowDeleted = await muscleLocalDB.delete(id);
    if (rowDeleted == 0) {
      throw NoRowAffectedException();
    } else if (1 < rowDeleted) {
      throw MultipleRowsAffectedException();
    }
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
