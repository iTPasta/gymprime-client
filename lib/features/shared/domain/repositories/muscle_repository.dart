import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/features/shared/domain/entities/muscle_entity.dart';
import 'package:objectid/objectid.dart';

abstract class MuscleRepository {
  Future<DataState<List<MuscleEntity>>> getAllMuscles();
  Future<DataState<MuscleEntity>> getMuscle(ObjectId id);
  Future<DataState<MuscleEntity>> createMuscle(MuscleEntity muscle);
  Future<DataState<MuscleEntity>> updateMuscle(MuscleEntity muscle);
  Future<DataState<ObjectId>> deleteMuscle(ObjectId id);
  Future<DataState<void>> synchronizeMuscles();
}
