import 'package:gymprime/features/shared/data/datasources/local/database/cached_request_local_db.dart';
import 'package:gymprime/features/shared/data/models/cache_request_model.dart';
import 'package:objectid/objectid.dart';

abstract class CachedRequestLocalDataSource {
  Future<List<CachedRequestModel>> getCachedRequests();
  Future<void> addCachedRequest(CachedRequestModel cachedRequest);
  Future<void> removeCachedRequest(ObjectId id);
}

class CachedRequestLocalDataSourceImpl implements CachedRequestLocalDataSource {
  final CachedRequestLocalDB _cachedRequestLocalDB = CachedRequestLocalDB();

  static final CachedRequestLocalDataSourceImpl _instance =
      CachedRequestLocalDataSourceImpl._internal();

  CachedRequestLocalDataSourceImpl._internal();

  factory CachedRequestLocalDataSourceImpl() {
    return _instance;
  }

  @override
  Future<CachedRequestModel> addCachedRequest(
      CachedRequestModel cachedRequest) {
    _cachedRequestLocalDB.insert(cachedRequestModel: cachedRequest);
    return Future.value(cachedRequest);
  }

  @override
  Future<ObjectId> removeCachedRequest(ObjectId id) {
    _cachedRequestLocalDB.delete(id: id);
    return Future.value(id);
  }

  @override
  Future<List<CachedRequestModel>> getCachedRequests() {
    return _cachedRequestLocalDB.fetchAll();
  }
}
