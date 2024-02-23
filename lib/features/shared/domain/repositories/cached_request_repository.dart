import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/features/shared/domain/entities/request_entity.dart';
import 'package:objectid/objectid.dart';

abstract class CachedRequestRepository {
  Future<DataState<List<RequestEntity>>> getCachedRequests();
  Future<DataState<void>> cacheRequest(RequestEntity cachedRequest);
  Future<DataState<void>> removeCachedRequest(ObjectId id);
}
