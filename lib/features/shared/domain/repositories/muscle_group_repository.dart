import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/features/shared/domain/entities/muscle_group_entity.dart';
import 'package:objectid/objectid.dart';

abstract class MuscleGroupRepository {
  Future<DataState<List<MuscleGroupEntity>>> getAllMuscleGroups();
  Future<DataState<MuscleGroupEntity>> getMuscleGroup(ObjectId id);
  Future<DataState<MuscleGroupEntity>> createMuscleGroup(
      MuscleGroupEntity muscleGroup);
  Future<DataState<MuscleGroupEntity>> updateMuscleGroup(
      MuscleGroupEntity muscleGroup);
  Future<DataState<ObjectId>> deleteMuscleGroup(ObjectId id);
  Future<DataState<void>> synchronizeMuscleGroups();
}
