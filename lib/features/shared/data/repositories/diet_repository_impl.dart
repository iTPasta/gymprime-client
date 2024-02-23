import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/features/shared/data/datasources/local/diet_local_datasource.dart';
import 'package:gymprime/features/shared/data/datasources/remote/diet_remote_datasource.dart';
import 'package:gymprime/features/shared/domain/entities/diet_entity.dart';
import 'package:gymprime/features/shared/domain/repositories/diet_repository.dart';
import 'package:objectid/objectid.dart';

class DietRepositoryImpl extends DietRepository {
  final DietRemoteDataSource remoteDataSource;
  final DietLocalDataSource localDataSource;

  DietRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<DataState<List<DietEntity>>> getAllDiets() async {
    try {
      return DataSuccess(await remoteDataSource.getAllDiets());
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<List<DietEntity>>> getMyDiets() async {
    try {
      return DataSuccess(await localDataSource.getMyDiets());
    } on CacheException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<DietEntity>> getDiet(ObjectId id) async {
    try {
      return DataSuccess(await localDataSource.getDiet(id));
    } on CacheException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<DietEntity>> createDiet(DietEntity diet) async {
    try {
      return DataSuccess(await localDataSource.createDiet(diet.toModel()));
    } on CacheException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<DietEntity>> updateDiet(DietEntity diet) async {
    // TODO: implement updateDiet
    throw UnimplementedError();
  }

  @override
  Future<DataState<ObjectId>> deleteDiet(ObjectId id) async {
    // TODO: implement deleteDiet
    throw UnimplementedError();
  }

  @override
  Future<DataState<void>> syncMyDiets() async {
    // TODO: implement syncMyDiets
    throw UnimplementedError();
  }
}
