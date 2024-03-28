import 'dart:convert';

import 'package:gymprime/core/enums/action_type.dart';
import 'package:gymprime/core/enums/model_type.dart';
import 'package:gymprime/features/shared/domain/entities/action_entity.dart';
import 'package:objectid/objectid.dart';

class ActionModel extends ActionEntity {
  const ActionModel({
    required super.id,
    required super.modelType,
    required super.actionType,
    required super.objectId,
    required super.date,
  });

  factory ActionModel.fromJson(Map<String, dynamic> map) {
    return ActionModel(
      id: jsonDecode(map['_id']) != null
          ? ObjectId.fromHexString(map['_id'])
          : ObjectId.fromHexString(map['id']),
      modelType: ModelTypeExtension.fromJson(map['modelType'])!,
      actionType: ActionTypeExtension.fromJson(map['actionType'])!,
      objectId: ObjectId.fromHexString(map['objectId']),
      date: map['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': jsonEncode(id),
      'modelType': jsonEncode(modelType),
      'actionType': jsonEncode(actionType),
      'objectId': jsonEncode(objectId),
      'date': jsonEncode(date),
    };
  }

  ActionEntity toEntity() {
    return ActionEntity(
      id: id,
      modelType: modelType,
      actionType: actionType,
      objectId: objectId,
      date: date,
    );
  }

  static List<ActionModel> fromJsonToList(
    List<Map<String, dynamic>> jsonActions,
  ) {
    final List<ActionModel> actionsList = [];
    for (final jsonAction in jsonActions) {
      actionsList.add(ActionModel.fromJson(jsonAction));
    }
    return actionsList;
  }
}
