import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/core/usecases/usecase.dart';
import 'package:gymprime/features/shared/domain/entities/program_entity.dart';
import 'package:gymprime/features/shared/domain/repositories/program_repository.dart';
import 'package:objectid/objectid.dart';

class GetAllPrograms implements UseCase<DataState<List<ProgramEntity>>, void> {
  final ProgramRepository repository;

  GetAllPrograms(this.repository);

  @override
  Future<DataState<List<ProgramEntity>>> call(void params) async {
    return await repository.getAllPrograms();
  }
}

class GetMyPrograms implements UseCase<DataState<List<ProgramEntity>>, void> {
  final ProgramRepository repository;

  GetMyPrograms(this.repository);

  @override
  Future<DataState<List<ProgramEntity>>> call(void params) async {
    return await repository.getMyPrograms();
  }
}

class GetProgram implements UseCase<DataState<ProgramEntity>, ObjectId> {
  final ProgramRepository repository;

  GetProgram(this.repository);

  @override
  Future<DataState<ProgramEntity>> call(ObjectId id) async {
    return await repository.getProgram(id);
  }
}

class CreateProgram
    implements UseCase<DataState<ProgramEntity>, ProgramEntity> {
  final ProgramRepository repository;

  CreateProgram(this.repository);

  @override
  Future<DataState<ProgramEntity>> call(ProgramEntity program) async {
    return await repository.createProgram(program);
  }
}

class UpdateProgram
    implements UseCase<DataState<ProgramEntity>, ProgramEntity> {
  final ProgramRepository repository;

  UpdateProgram(this.repository);

  @override
  Future<DataState<ProgramEntity>> call(ProgramEntity program) async {
    return await repository.updateProgram(program);
  }
}

class DeleteProgram implements UseCase<DataState<ObjectId>, ObjectId> {
  final ProgramRepository repository;

  DeleteProgram(this.repository);

  @override
  Future<DataState<ObjectId>> call(ObjectId id) async {
    return await repository.deleteProgram(id);
  }
}

class SynchronizePrograms implements UseCase<DataState<void>, void> {
  final ProgramRepository repository;

  SynchronizePrograms(this.repository);

  @override
  Future<DataState<void>> call(void params) async {
    return await repository.synchronizePrograms();
  }
}
