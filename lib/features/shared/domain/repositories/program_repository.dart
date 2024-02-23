import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/features/shared/domain/entities/program_entity.dart';
import 'package:objectid/objectid.dart';

abstract class ProgramRepository {
  Future<DataState<List<ProgramEntity>>> getAllPrograms();
  Future<DataState<List<ProgramEntity>>> getMyPrograms();
  Future<DataState<ProgramEntity>> getProgram(ObjectId id);
  Future<DataState<ProgramEntity>> createProgram(ProgramEntity programEntity);
  Future<DataState<ProgramEntity>> updateProgram(ProgramEntity programEntity);
  Future<DataState<ObjectId>> deleteProgram(ObjectId id);
  Future<DataState<void>> syncMyPrograms();
}
