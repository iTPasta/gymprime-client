import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/features/shared/domain/entities/muscle_group_entity.dart';
import 'package:objectid/objectid.dart';

abstract class MuscleGroupRepository {
  Future<DataState<List<MuscleGroupEntity>>> getAllMuscleGroups();
  Future<DataState<MuscleGroupEntity>> getMuscleGroup(ObjectId id);
  Future<DataState<MuscleGroupEntity>> createMuscleGroup(
      MuscleGroupEntity muscleGroupEntity);
  Future<DataState<MuscleGroupEntity>> updateMuscleGroup(
      MuscleGroupEntity muscleGroupEntity);
  Future<DataState<ObjectId>> deleteMuscleGroup(ObjectId id);
}
