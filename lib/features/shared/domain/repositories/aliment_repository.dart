import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/features/shared/domain/entities/aliment_entity.dart';
import 'package:objectid/objectid.dart';

abstract class AlimentRepository {
  Future<DataState<List<AlimentEntity>>> getAllAliments();
  Future<DataState<AlimentEntity>> getAliment(ObjectId id);
  Future<DataState<AlimentEntity>> createAliment(AlimentEntity aliment);
  Future<DataState<AlimentEntity>> updateAliment(AlimentEntity aliment);
  Future<DataState<ObjectId>> deleteAliment(ObjectId id);
  Future<DataState<void>> synchronizeAliments();
}
