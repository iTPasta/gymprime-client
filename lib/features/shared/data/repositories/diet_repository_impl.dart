import 'package:dartz/dartz.dart';
import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/core/errors/failures.dart';
import 'package:gymprime/core/platform/network_info.dart';
import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/core/extensions/objectid_extension.dart';
import 'package:gymprime/features/shared/data/datasources/local/diet_local_datasource.dart';
import 'package:gymprime/features/shared/data/datasources/remote/diet_remote_datasource.dart';
import 'package:gymprime/features/shared/domain/entities/diet_entity.dart';
import 'package:gymprime/features/shared/domain/repositories/diet_repository.dart';

class DietRepositoryImpl extends DietRepository {
  final DietRemoteDataSource remoteDataSource;
  final DietLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  DietRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<DataState<List<DietEntity>>> getMyDiets() async {
    if (await networkInfo.isConnected) {
      try {} on ServerException {
        final remoteDiets = await remoteDataSource.getMyDiets();
        return const Left(ServerFailure(""));
      }
    } else {
      // TODO: cache action
    }
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, DietEntity>> getDiet(ObjectId id) {
    // TODO: implement getDiet
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, DietEntity>> createDiet(DietEntity diet) async {
    if (await networkInfo.isConnected) {
    } else {
      // TODO: cache data
    }
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, DietEntity>> updateDiet(DietEntity diet) {
    // TODO: implement updateDiet
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ObjectId>> deleteDiet(ObjectId id) async {
    // TODO: implement deleteDiet
    throw UnimplementedError();
  }
}
