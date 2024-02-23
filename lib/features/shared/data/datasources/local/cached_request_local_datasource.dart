import 'package:gymprime/features/shared/data/datasources/local/database/cached_request_local_db.dart';
import 'package:gymprime/features/shared/data/models/request_model.dart';
import 'package:objectid/objectid.dart';

abstract class CachedRequestLocalDataSource {
  Future<List<RequestModel>> getCachedRequests();
  Future<void> cacheRequest(RequestModel cachedRequest);
  Future<void> removeCachedRequest(ObjectId id);
}

class CachedRequestLocalDataSourceImpl implements CachedRequestLocalDataSource {
  final CachedRequestLocalDB cachedRequestLocalDB;

  CachedRequestLocalDataSourceImpl({
    required this.cachedRequestLocalDB,
  });

  @override
  Future<RequestModel> cacheRequest(RequestModel cachedRequest) {
    cachedRequestLocalDB.insert(cachedRequestModel: cachedRequest);
    return Future.value(cachedRequest);
  }

  @override
  Future<ObjectId> removeCachedRequest(ObjectId id) {
    cachedRequestLocalDB.delete(id: id);
    return Future.value(id);
  }

  @override
  Future<List<RequestModel>> getCachedRequests() {
    return cachedRequestLocalDB.fetchAll();
  }
}
