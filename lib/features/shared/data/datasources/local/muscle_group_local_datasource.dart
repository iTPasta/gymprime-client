import 'package:gymprime/features/shared/data/datasources/local/database/muscle_group_local_db.dart';
import 'package:gymprime/features/shared/data/models/muscle_group_model.dart';
import 'package:objectid/objectid.dart';

abstract class MuscleGroupLocalDataSource {
  Future<List<MuscleGroupModel>> getAllMuscleGroups();
  Future<MuscleGroupModel> getMuscleGroup(ObjectId id);
  Future<MuscleGroupModel> createMuscleGroup(MuscleGroupModel muscleGroup);
  Future<MuscleGroupModel> updateMuscleGroup(
      ObjectId id, MuscleGroupModel muscleGroup);
  Future<ObjectId> deleteMuscleGroup(ObjectId id);
}

class MuscleGroupLocalDataSourceImpl implements MuscleGroupLocalDataSource {
  final MuscleGroupLocalDB _muscleGroupLocalDB = MuscleGroupLocalDB();

  @override
  Future<MuscleGroupModel> createMuscleGroup(MuscleGroupModel muscleGroup) {
    _muscleGroupLocalDB.insert(muscleGroupModel: muscleGroup);
    return Future.value(muscleGroup);
  }

  @override
  Future<ObjectId> deleteMuscleGroup(ObjectId id) {
    _muscleGroupLocalDB.delete(id: id);
    return Future.value(id);
  }

  @override
  Future<MuscleGroupModel> getMuscleGroup(ObjectId id) {
    return _muscleGroupLocalDB.fetchById(id: id);
  }

  @override
  Future<List<MuscleGroupModel>> getAllMuscleGroups() {
    return _muscleGroupLocalDB.fetchAll();
  }

  @override
  Future<MuscleGroupModel> updateMuscleGroup(
    ObjectId id,
    MuscleGroupModel muscleGroup,
  ) {
    _muscleGroupLocalDB.update(id: id, muscleGroupModel: muscleGroup);
    return Future.value(muscleGroup);
  }
}
