import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/core/platform/network_info.dart';
import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/features/shared/data/datasources/remote/aliment_remote_datasource.dart';
import 'package:gymprime/features/shared/data/models/aliment_model.dart';
import 'package:gymprime/features/shared/domain/entities/aliment_entity.dart';
import 'package:gymprime/features/shared/domain/repositories/aliment_repository.dart';
import 'package:objectid/objectid.dart';

class AlimentRepositoryNoCacheImpl extends AlimentRepository {
  final AlimentRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AlimentRepositoryNoCacheImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<DataState<List<AlimentEntity>>> getAllAliments() async {
    try {
      return DataSuccess((await remoteDataSource.getAllAliments()).$1);
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<AlimentEntity>> getAliment(ObjectId id) async {
    try {
      return DataSuccess(await remoteDataSource.getAliment(id));
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<AlimentEntity>> createAliment(AlimentEntity aliment) async {
    try {
      ObjectId alimentId =
          (await remoteDataSource.createAliment(aliment.toModel())).$1;

      return DataSuccess(AlimentModel(
        id: alimentId,
        barCode: aliment.barCode,
        name: aliment.name,
        nutriments: aliment.nutriments,
        allergens: aliment.allergens,
        brands: aliment.brands,
        ciqualCode: aliment.ciqualCode,
        countryCode: aliment.countryCode,
        ecoscoreGrade: aliment.ecoscoreGrade,
        ecoscoreScore: aliment.ecoscoreScore,
        imageUrl: aliment.imageUrl,
        nutriscoreGrade: aliment.nutriscoreGrade,
        nutriscoreScore: aliment.nutriscoreScore,
      ));
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<AlimentEntity>> updateAliment(AlimentEntity aliment) async {
    try {
      await remoteDataSource.updateAliment(aliment.toModel());
      return DataSuccess(aliment);
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<ObjectId>> deleteAliment(ObjectId id) async {
    try {
      await remoteDataSource.deleteAliment(id);
      return DataSuccess(id);
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<void>> synchronizeAliments() async {
    return const DataSuccess(null);
  }
}
