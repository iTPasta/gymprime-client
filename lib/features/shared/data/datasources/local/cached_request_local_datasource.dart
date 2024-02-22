import 'package:gymprime/features/shared/data/datasources/local/database/cached_request_local_db.dart';
import 'package:gymprime/features/shared/data/models/cache_request_model.dart';
import 'package:objectid/objectid.dart';

abstract class CachedRequestLocalDataSource {
  Future<List<CachedRequestModel>> getCachedRequests();
  Future<void> addCachedRequest(CachedRequestModel cachedRequest);
  Future<void> removeCachedRequest(ObjectId id);
}

class CachedRequestLocalDataSourceImpl implements CachedRequestLocalDataSource {
  final CachedRequestLocalDB cachedRequestLocalDB;

  CachedRequestLocalDataSourceImpl({
    required this.cachedRequestLocalDB,
  });

  @override
  Future<CachedRequestModel> addCachedRequest(
      CachedRequestModel cachedRequest) {
    cachedRequestLocalDB.insert(cachedRequestModel: cachedRequest);
    return Future.value(cachedRequest);
  }

  @override
  Future<ObjectId> removeCachedRequest(ObjectId id) {
    cachedRequestLocalDB.delete(id: id);
    return Future.value(id);
  }

  @override
  Future<List<CachedRequestModel>> getCachedRequests() {
    return cachedRequestLocalDB.fetchAll();
  }
}
