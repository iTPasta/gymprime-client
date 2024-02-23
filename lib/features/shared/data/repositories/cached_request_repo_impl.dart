import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/features/shared/data/datasources/local/cached_request_local_datasource.dart';
import 'package:gymprime/features/shared/data/models/request_model.dart';
import 'package:gymprime/features/shared/domain/entities/request_entity.dart';
import 'package:gymprime/features/shared/domain/repositories/cached_request_repository.dart';
import 'package:objectid/objectid.dart';

class CachedRequestRepositoryImpl implements CachedRequestRepository {
  final CachedRequestLocalDataSource cachedRequestDataSource;

  CachedRequestRepositoryImpl({
    required this.cachedRequestDataSource,
  });

  @override
  Future<DataState<List<RequestModel>>> getCachedRequests() async {
    try {
      return DataSuccess(await cachedRequestDataSource.getCachedRequests());
    } on CacheException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<void>> cacheRequest(
    RequestEntity request,
  ) async {
    try {
      return DataSuccess(
        await cachedRequestDataSource.cacheRequest(request.toModel()),
      );
    } on CacheException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<void>> removeCachedRequest(ObjectId id) async {
    try {
      return DataSuccess(await cachedRequestDataSource.removeCachedRequest(id));
    } on CacheException catch (exception) {
      return DataFailure(exception);
    }
  }
}
