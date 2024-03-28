import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/core/platform/network_info.dart';
import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/features/shared/data/datasources/remote/program_remote_datasource.dart';
import 'package:gymprime/features/shared/data/models/program_model.dart';
import 'package:gymprime/features/shared/domain/entities/program_entity.dart';
import 'package:gymprime/features/shared/domain/repositories/program_repository.dart';
import 'package:objectid/objectid.dart';

class ProgramRepositoryNoCacheImpl extends ProgramRepository {
  final ProgramRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProgramRepositoryNoCacheImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<DataState<List<ProgramEntity>>> getAllPrograms() async {
    try {
      return DataSuccess(await remoteDataSource.getAllPrograms());
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<List<ProgramEntity>>> getMyPrograms() async {
    try {
      return DataSuccess((await remoteDataSource.getMyPrograms()).$1);
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<ProgramEntity>> getProgram(ObjectId id) async {
    try {
      return DataSuccess(await remoteDataSource.getProgram(id));
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<ProgramEntity>> createProgram(ProgramEntity program) async {
    try {
      ObjectId programId =
          (await remoteDataSource.createProgram(program.toModel())).$1;

      return DataSuccess(ProgramModel(
        id: programId,
        name: program.name,
        description: program.description,
        exercises: program.exercises,
        trainings: program.trainings,
        goal: program.goal,
      ));
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<ProgramEntity>> updateProgram(ProgramEntity program) async {
    try {
      await remoteDataSource.updateProgram(program.toModel());
      return DataSuccess(program);
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<ObjectId>> deleteProgram(ObjectId id) async {
    try {
      await remoteDataSource.deleteProgram(id);
      return DataSuccess(id);
    } on ServerException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<void>> synchronizePrograms() async {
    return const DataSuccess(null);
  }
}
