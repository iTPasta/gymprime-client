import 'package:gymprime/core/enums/action_type.dart';
import 'package:gymprime/core/enums/model_type.dart';
import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/core/platform/network_info.dart';
import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/features/shared/data/datasources/local/action_local_database.dart';
import 'package:gymprime/features/shared/data/datasources/local/diet_local_datasource.dart';
import 'package:gymprime/features/shared/data/datasources/remote/diet_remote_datasource.dart';
import 'package:gymprime/features/shared/data/models/diet_model.dart';
import 'package:gymprime/features/shared/domain/entities/action_entity.dart';
import 'package:gymprime/features/shared/domain/entities/diet_entity.dart';
import 'package:gymprime/features/shared/domain/repositories/diet_repository.dart';
import 'package:objectid/objectid.dart';

class DietRepositoryCacheImpl extends DietRepository {
  final DietRemoteDataSource remoteDataSource;
  final DietLocalDataSource localDataSource;
  final ActionLocalDataSourceImpl cachedActionsDataSource;
  final NetworkInfo networkInfo;

  DietRepositoryCacheImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.cachedActionsDataSource,
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
      await localDataSource.createDiet(diet.toModel());
      if (await networkInfo.isConnected) {
        try {
          final (remoteDietId, oldDietsLastUpdate, dietsLastUpdate) =
              await remoteDataSource.createDiet(diet.toModel());
          if (oldDietsLastUpdate == localDataSource.getDietsLastUpdate()!) {
            final DietEntity remoteDiet = DietEntity(
              id: remoteDietId,
              name: diet.name,
              description: diet.description,
              meals: diet.meals,
            );
            await localDataSource.updateDiet(diet.id, remoteDiet.toModel());
            localDataSource.setDietsLastUpdate(dietsLastUpdate);
            return DataSuccess(remoteDiet);
          } else {
            final (diets, dietsLastUpdate) =
                await remoteDataSource.getMyDiets();
            await localDataSource.setMyDiets(diets);
            localDataSource.setDietsLastUpdate(dietsLastUpdate);
            return DataSuccess(diet);
          }
        } on ServerException catch (exception) {
          return DataFailure(exception);
        }
      } else {
        final ActionEntity createDietAction = ActionEntity(
          id: ObjectId(),
          modelType: ModelType.diet,
          actionType: ActionType.create,
          objectId: diet.id,
          date: DateTime.now().millisecondsSinceEpoch,
        );

        if (await cachedActionsDataSource.cachedActionExists(
          modelType: ModelType.diet,
          objectId: diet.id,
        )) {
          throw CacheInconsistencyException(
            cache: await cachedActionsDataSource.getCachedActions(),
            cachedObject: createDietAction.toModel(),
          );
        }

        await cachedActionsDataSource.cacheAction(createDietAction.toModel());
        return DataSuccess(diet);
      }
    } on CacheException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<DietEntity>> updateDiet(DietEntity diet) async {
    try {
      await localDataSource.updateDiet(diet.id, diet.toModel());
      if (await networkInfo.isConnected) {
        try {
          final (oldDietsLastUpdate, dietsLastUpdate) =
              await remoteDataSource.updateDiet(diet.toModel());
          if (oldDietsLastUpdate == localDataSource.getDietsLastUpdate()!) {
            localDataSource.setDietsLastUpdate(dietsLastUpdate);
            return DataSuccess(diet);
          } else {
            final (diets, dietsLastUpdate) =
                await remoteDataSource.getMyDiets();
            await localDataSource.setMyDiets(diets);
            localDataSource.setDietsLastUpdate(dietsLastUpdate);
            return DataSuccess(diet);
          }
        } on ServerException catch (exception) {
          return DataFailure(exception);
        }
      } else {
        final ActionEntity updateDietAction = ActionEntity(
          id: ObjectId(),
          modelType: ModelType.diet,
          actionType: ActionType.update,
          objectId: diet.id,
          date: DateTime.now().millisecondsSinceEpoch,
        );

        if (await cachedActionsDataSource.cachedActionExists(
          modelType: ModelType.diet,
          actionType: ActionType.delete,
          objectId: diet.id,
        )) {
          throw CacheInconsistencyException(
            cache: await cachedActionsDataSource.getCachedActions(),
            cachedObject: updateDietAction.toModel(),
          );
        }

        if (!await cachedActionsDataSource.cachedActionExists(
          modelType: ModelType.diet,
          objectId: diet.id,
        )) {
          await cachedActionsDataSource.cacheAction(updateDietAction.toModel());
        }

        return DataSuccess(diet);
      }
    } on CacheException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<ObjectId>> deleteDiet(ObjectId id) async {
    try {
      await localDataSource.deleteDiet(id);
      if (await networkInfo.isConnected) {
        try {
          final (oldDietsLastUpdate, dietsLastUpdate) =
              await remoteDataSource.deleteDiet(id);
          if (oldDietsLastUpdate == localDataSource.getDietsLastUpdate()!) {
            localDataSource.setDietsLastUpdate(dietsLastUpdate);
            return DataSuccess(id);
          } else {
            final (diets, dietsLastUpdate) =
                await remoteDataSource.getMyDiets();
            await localDataSource.setMyDiets(diets);
            localDataSource.setDietsLastUpdate(dietsLastUpdate);
            return DataSuccess(id);
          }
        } on ServerException catch (exception) {
          return DataFailure(exception);
        }
      } else {
        final ActionEntity deleteDietAction = ActionEntity(
          id: ObjectId(),
          modelType: ModelType.diet,
          actionType: ActionType.delete,
          objectId: id,
          date: DateTime.now().millisecondsSinceEpoch,
        );

        final List<ActionEntity> createCachedActions =
            await cachedActionsDataSource.getCachedActions(
          modelType: ModelType.diet,
          actionType: ActionType.create,
          objectId: id,
        );

        final List<ActionEntity> updateCachedActions =
            await cachedActionsDataSource.getCachedActions(
          modelType: ModelType.diet,
          actionType: ActionType.update,
          objectId: id,
        );

        if (await cachedActionsDataSource.cachedActionExists(
          modelType: ModelType.diet,
          actionType: ActionType.delete,
          objectId: id,
        )) {
          throw CacheInconsistencyException(
            cache: await cachedActionsDataSource.getCachedActions(),
            cachedObject: deleteDietAction.toModel(),
          );
        }

        if ((createCachedActions.isNotEmpty &&
            updateCachedActions.isNotEmpty)) {
          throw CacheInconsistencyException(
            cache: await cachedActionsDataSource.getCachedActions(),
            cachedObject: deleteDietAction.toModel(),
          );
        }

        if (createCachedActions.isNotEmpty) {
          for (ActionEntity createCachedAction in createCachedActions) {
            await cachedActionsDataSource
                .removeCachedAction(createCachedAction.id);
          }
        } else if (updateCachedActions.isNotEmpty) {
          for (ActionEntity updateCachedAction in updateCachedActions) {
            await cachedActionsDataSource
                .removeCachedAction(updateCachedAction.id);
          }
          await cachedActionsDataSource.cacheAction(deleteDietAction.toModel());
        } else if (createCachedActions.isEmpty && updateCachedActions.isEmpty) {
          await cachedActionsDataSource.cacheAction(deleteDietAction.toModel());
        }

        return DataSuccess(id);
      }
    } on CacheException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<void>> synchronizeDiets() async {
    final List<ObjectId> createdDietIds =
        await cachedActionsDataSource.getCachedActionsObjectIds(
      modelType: ModelType.diet,
      actionType: ActionType.create,
    );

    final List<ObjectId> updatedDietIds =
        await cachedActionsDataSource.getCachedActionsObjectIds(
      modelType: ModelType.diet,
      actionType: ActionType.update,
    );

    final List<ObjectId> deletedDietIds =
        await cachedActionsDataSource.getCachedActionsObjectIds(
      modelType: ModelType.diet,
      actionType: ActionType.update,
    );

    final List<DietEntity> createdDiets = [];
    for (ObjectId createdDietId in createdDietIds) {
      createdDiets.add(await localDataSource.getDiet(createdDietId));
    }

    final List<DietEntity> updatedDiets = [];
    for (ObjectId updatedDietId in updatedDietIds) {
      updatedDiets.add(await localDataSource.getDiet(updatedDietId));
    }

    // ignore: unused_local_variable
    final (List<DietModel> diets, int dietsLastUpdate, String? warning) =
        await remoteDataSource.synchronizeDiets(
      createdDiets: createdDiets.toModelList(),
      updatedDiets: updatedDiets.toModelList(),
      deletedDiets: deletedDietIds,
    );

    await localDataSource.setMyDiets(diets);
    localDataSource.setDietsLastUpdate(dietsLastUpdate);
    return const DataSuccess(null);
  }
}
