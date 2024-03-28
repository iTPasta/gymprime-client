// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:gymprime/core/enums/model_type.dart';
import 'package:gymprime/core/enums/action_type.dart';
import 'package:gymprime/features/shared/data/models/action_model.dart';
import 'package:objectid/objectid.dart';

class ActionEntity {
  final ObjectId id;
  final ActionType actionType;
  final ModelType modelType;
  final ObjectId objectId;
  final int date;

  const ActionEntity({
    required this.id,
    required this.actionType,
    required this.modelType,
    required this.objectId,
    required this.date,
  });

  List<Object?> get props {
    return [
      modelType,
      actionType,
      objectId,
      date,
    ];
  }

  ActionModel toModel() {
    return ActionModel(
      id: id,
      modelType: modelType,
      actionType: actionType,
      objectId: objectId,
      date: date,
    );
  }

  static List<ActionModel> fromEntityListToModelList(
    List<ActionEntity> actionEntities,
  ) {
    final List<ActionModel> actionModels = [];
    for (ActionEntity actionEntity in actionEntities) {
      actionModels.add(actionEntity.toModel());
    }
    return actionModels;
  }
}
