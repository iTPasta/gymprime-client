import 'package:dartz/dartz.dart';
import 'package:gymprime/core/errors/failures.dart';
import 'package:gymprime/core/resources/success_no_return.dart';
import 'package:gymprime/core/usecases/usecase.dart';
import 'package:gymprime/features/shared/domain/entities/request_entity.dart';
import 'package:gymprime/features/shared/domain/repositories/cached_request_repository.dart';

class GetCachedRequests implements UseCase<List<RequestEntity>, Null> {
  final CachedRequestRepository repository;

  GetCachedRequests(this.repository);

  @override
  Future<Either<Failure, List<RequestEntity>>> call(Null nullParam) async {
    return await repository.getCachedRequests();
  }
}

class AddCachedRequest implements UseCase<SuccessNoReturn, RequestEntity> {
  final CachedRequestRepository repository;

  AddCachedRequest(this.repository);

  @override
  Future<Either<Failure, SuccessNoReturn>> call(
      RequestEntity cachedRequest) async {
    return await repository.addCachedRequest(cachedRequest);
  }
}

class RemoveCachedRequest implements UseCase<SuccessNoReturn, int> {
  final CachedRequestRepository repository;

  RemoveCachedRequest(this.repository);

  @override
  Future<Either<Failure, SuccessNoReturn>> call(int requestId) async {
    return await repository.removeCacheRequest(requestId);
  }
}
