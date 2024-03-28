import 'package:gymprime/core/enums/action_type.dart';
import 'package:gymprime/core/enums/model_type.dart';
import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/features/shared/data/datasources/local/database/action_local_db.dart';
import 'package:gymprime/features/shared/data/models/action_model.dart';
import 'package:objectid/objectid.dart';

abstract class CachedActionLocalDataSource {
  Future<List<ActionModel>> getCachedActions({
    ModelType? modelType,
    ActionType? actionType,
    ObjectId? objectId,
    int? date,
  });
  Future<bool> cachedActionExists({
    ModelType? modelType,
    ActionType? actionType,
    ObjectId? objectId,
    int? date,
  });
  Future<List<ObjectId>> getCachedActionsObjectIds({
    ModelType? modelType,
    ActionType? actionType,
    ObjectId? objectId,
    int? date,
  });
  Future<void> cacheAction(ActionModel action);
  Future<void> removeCachedAction(ObjectId id);
}

class ActionLocalDataSourceImpl implements CachedActionLocalDataSource {
  final ActionLocalDB actionLocalDB;

  ActionLocalDataSourceImpl({
    required this.actionLocalDB,
  });

  @override
  Future<List<ActionModel>> getCachedActions({
    ModelType? modelType,
    ActionType? actionType,
    ObjectId? objectId,
    int? date,
  }) async {
    final List<ActionModel> actions = await actionLocalDB.fetchAll();
    if (objectId != null) {
      for (final ActionModel action in actions) {
        if (action.objectId != objectId) {
          actions.remove(action);
        }
      }
    }
    if (date != null) {
      for (final ActionModel action in actions) {
        if (action.date != date) {
          actions.remove(action);
        }
      }
    }
    if (modelType != null) {
      for (final ActionModel action in actions) {
        if (action.modelType != modelType) {
          actions.remove(action);
        }
      }
    }
    if (actionType != null) {
      for (final ActionModel action in actions) {
        if (action.actionType != actionType) {
          actions.remove(action);
        }
      }
    }
    return actions;
  }

  @override
  Future<bool> cachedActionExists({
    ModelType? modelType,
    ActionType? actionType,
    ObjectId? objectId,
    int? date,
  }) async {
    return (await getCachedActions(
      modelType: modelType,
      actionType: actionType,
      objectId: objectId,
      date: date,
    ))
        .isNotEmpty;
  }

  @override
  Future<List<ObjectId>> getCachedActionsObjectIds({
    ModelType? modelType,
    ActionType? actionType,
    ObjectId? objectId,
    int? date,
  }) async {
    final List<ObjectId> objectIds = [];
    final List<ActionModel> actions = await getCachedActions(
      modelType: modelType,
      actionType: actionType,
      objectId: objectId,
      date: date,
    );
    for (ActionModel action in actions) {
      objectIds.add(action.objectId);
    }
    return objectIds;
  }

  @override
  Future<void> cacheAction(ActionModel action) async {
    final int id = await actionLocalDB.insert(action);
    if (id == 0) {
      throw NoRowInsertedException();
    }
  }

  @override
  Future<void> removeCachedAction(ObjectId id) async {
    final int rowsAffected = await actionLocalDB.delete(id);
    if (rowsAffected == 0) {
      throw NoRowAffectedException();
    } else if (rowsAffected > 1) {
      throw MultipleRowsAffectedException();
    }
  }
}
