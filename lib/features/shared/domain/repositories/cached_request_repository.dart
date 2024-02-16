import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/features/shared/domain/entities/cached_request_entity.dart';

abstract class CachedRequestRepository {
  Future<DataState<List<CachedRequestEntity>>> getCachedRequests();
  Future<DataState<void>> addCachedRequest(CachedRequestEntity cachedRequest);
  Future<DataState<void>> removeCacheRequest(int id);
}
