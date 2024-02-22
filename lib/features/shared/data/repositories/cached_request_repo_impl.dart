import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/core/errors/failures.dart';
import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/features/shared/data/datasources/local/cached_request_local_datasource.dart';
import 'package:gymprime/features/shared/data/models/cache_request_model.dart';
import 'package:gymprime/features/shared/domain/entities/cached_request_entity.dart';
import 'package:gymprime/features/shared/domain/repositories/cached_request_repository.dart';

class CachedRequestRepositoryImpl implements CachedRequestRepository {
  final CachedRequestDataSource cachedRequestDataSource;

  CachedRequestRepositoryImpl({
    required this.cachedRequestDataSource,
  });

  @override
  Future<DataState<List<CachedRequestModel>>> getCachedRequests() async {
    try {
      final cachedRequests = await cachedRequestDataSource.getCachedRequests();
      return DataSuccess(cachedRequests);
    } on CacheException {
      return DataFailure(Exception(requestOptions: requestOptions));
    }
  }

  @override
  Future<DataState<void>> addCachedRequest(
    CachedRequestEntity cachedRequest,
  ) async {
    try {
      await cachedRequestDataSource.addCachedRequest(cachedRequest.toModel());
      return const DataSuccess();
    } on CacheException {
      return DataFailure(CacheFailure(
        "Failed to add a request into the cache.",
      ));
    }
  }

  @override
  Future<Either<Failure, SuccessNoReturn>> removeCacheRequest(
    int requestId,
  ) async {
    try {
      await cachedRequestDataSource.removeCachedRequest(requestId);
      return Right(SuccessNoReturn());
    } on CacheException {
      return const Left(CacheFailure(
        "Failed to remove a request from the cache.",
      ));
    }
  }
}
