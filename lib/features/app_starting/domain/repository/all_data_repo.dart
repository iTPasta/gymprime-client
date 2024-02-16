import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/core/resources/object_entity.dart';

abstract class AllDataRepository {
  Future<DataState<Map<ObjectEntity, List<dynamic>>>> fetchAllData();
}
