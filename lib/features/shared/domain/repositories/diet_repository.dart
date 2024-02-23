import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/features/shared/domain/entities/diet_entity.dart';
import 'package:objectid/objectid.dart';

abstract class DietRepository {
  Future<DataState<List<DietEntity>>> getAllDiets();
  Future<DataState<List<DietEntity>>> getMyDiets();
  Future<DataState<DietEntity>> getDiet(ObjectId id);
  Future<DataState<DietEntity>> createDiet(DietEntity diet);
  Future<DataState<DietEntity>> updateDiet(DietEntity diet);
  Future<DataState<ObjectId>> deleteDiet(ObjectId id);
  Future<DataState<void>> syncMyDiets();
}
