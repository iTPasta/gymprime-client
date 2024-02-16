import 'package:gymprime/core/errors/failures.dart';
import 'package:gymprime/core/extensions/objectid_extension.dart';
import 'package:gymprime/core/usecases/usecase.dart';
import 'package:gymprime/features/shared/domain/entities/diet_entity.dart';
import 'package:gymprime/features/shared/domain/repositories/diet_repository.dart';

class GetMyDiets implements UseCase<List<DietEntity>, Null> {
  final DietRepository repository;

  GetMyDiets(this.repository);

  @override
  Future<Either<Failure, List<DietEntity>>> call(Null nullParam) async {
    return await repository.getMyDiets();
  }
}

class GetDiet implements UseCase<DietEntity, ObjectId> {
  final DietRepository repository;

  GetDiet(this.repository);

  @override
  Future<Either<Failure, DietEntity>> call(ObjectId id) async {
    return await repository.getDiet(id);
  }
}

class CreateDiet implements UseCase<DietEntity, DietEntity> {
  final DietRepository repository;

  CreateDiet(this.repository);

  @override
  Future<Either<Failure, DietEntity>> call(DietEntity diet) async {
    return await repository.createDiet(diet);
  }
}

class UpdateDiet implements UseCase<DietEntity, DietEntity> {
  final DietRepository repository;

  UpdateDiet(this.repository);

  @override
  Future<Either<Failure, DietEntity>> call(DietEntity diet) async {
    return await repository.updateDiet(diet);
  }
}

class DeleteDiet implements UseCase<ObjectId, ObjectId> {
  final DietRepository repository;

  DeleteDiet(this.repository);

  @override
  Future<Either<Failure, ObjectId>> call(ObjectId id) async {
    return await repository.deleteDiet(id);
  }
}
