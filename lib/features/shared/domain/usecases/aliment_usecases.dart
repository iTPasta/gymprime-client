import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/core/usecases/usecase.dart';
import 'package:gymprime/features/shared/domain/entities/aliment_entity.dart';
import 'package:gymprime/features/shared/domain/repositories/aliment_repository.dart';
import 'package:objectid/objectid.dart';

class GetAllAliments implements UseCase<DataState<List<AlimentEntity>>, void> {
  final AlimentRepository repository;

  GetAllAliments(this.repository);

  @override
  Future<DataState<List<AlimentEntity>>> call(void params) async {
    return await repository.getAllAliments();
  }
}

class GetAliment implements UseCase<DataState<AlimentEntity>, ObjectId> {
  final AlimentRepository repository;

  GetAliment(this.repository);

  @override
  Future<DataState<AlimentEntity>> call(ObjectId id) async {
    return await repository.getAliment(id);
  }
}

class CreateAliment
    implements UseCase<DataState<AlimentEntity>, AlimentEntity> {
  final AlimentRepository repository;

  CreateAliment(this.repository);

  @override
  Future<DataState<AlimentEntity>> call(AlimentEntity aliment) async {
    return await repository.createAliment(aliment);
  }
}

class UpdateAliment
    implements UseCase<DataState<AlimentEntity>, AlimentEntity> {
  final AlimentRepository repository;

  UpdateAliment(this.repository);

  @override
  Future<DataState<AlimentEntity>> call(AlimentEntity aliment) async {
    return await repository.updateAliment(aliment);
  }
}

class DeleteAliment implements UseCase<DataState<ObjectId>, ObjectId> {
  final AlimentRepository repository;

  DeleteAliment(this.repository);

  @override
  Future<DataState<ObjectId>> call(ObjectId id) async {
    return await repository.deleteAliment(id);
  }
}

class SynchronizeAliments implements UseCase<DataState<void>, void> {
  final AlimentRepository repository;

  SynchronizeAliments(this.repository);

  @override
  Future<DataState<void>> call(void params) async {
    return await repository.synchronizeAliments();
  }
}
