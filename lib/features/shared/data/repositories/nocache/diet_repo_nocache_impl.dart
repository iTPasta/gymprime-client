import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/core/platform/network_info.dart';
import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/features/shared/data/datasources/remote/diet_remote_datasource.dart';
import 'package:gymprime/features/shared/data/models/diet_model.dart';
import 'package:gymprime/features/shared/domain/entities/diet_entity.dart';
import 'package:gymprime/features/shared/domain/repositories/diet_repository.dart';
import 'package:objectid/objectid.dart';

class DietRepositoryNoCacheImpl extends DietRepository {
  final DietRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DietRepositoryNoCacheImpl({
    required this.remoteDataSource,
    required this.networkInfo,
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
      return DataSuccess((await remoteDataSource.getMyDiets()).$1);
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<DietEntity>> getDiet(ObjectId id) async {
    try {
      return DataSuccess(await remoteDataSource.getDiet(id));
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<DietEntity>> createDiet(DietEntity diet) async {
    try {
      ObjectId dietId = (await remoteDataSource.createDiet(diet.toModel())).$1;

      return DataSuccess(DietModel(
        id: dietId,
        name: diet.name,
        description: diet.description,
        meals: diet.meals,
      ));
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<DietEntity>> updateDiet(DietEntity diet) async {
    try {
      await remoteDataSource.updateDiet(diet.toModel());
      return DataSuccess(diet);
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<ObjectId>> deleteDiet(ObjectId id) async {
    try {
      await remoteDataSource.deleteDiet(id);
      return DataSuccess(id);
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<void>> synchronizeDiets() async {
    return const DataSuccess(null);
  }
}
