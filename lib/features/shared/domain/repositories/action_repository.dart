import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/features/shared/domain/entities/action_entity.dart';
import 'package:objectid/objectid.dart';

abstract class CachedActionRepository {
  Future<DataState<List<ActionEntity>>> getCachedActions();
  Future<DataState<void>> cachedAction(ActionEntity request);
  Future<DataState<void>> removeCachedAction(ObjectId id);
  Future<DataState<void>> sendAction(ActionEntity request);
}
