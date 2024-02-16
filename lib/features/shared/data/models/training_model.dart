import 'dart:convert';

import 'package:gymprime/features/shared/domain/entities/training_entity.dart';

class TrainingModel extends TrainingEntity {
  const TrainingModel({
    required super.id,
    super.name,
    super.notes,
    required super.sets,
  });

  factory TrainingModel.fromJson(Map<String, dynamic> map) {
    return TrainingModel(
      id: map['_id'] ?? map['id'],
      name: map['name'],
      notes: map['notes'],
      sets: map['sets'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': jsonEncode(id),
      'name': jsonEncode(name),
      'notes': jsonEncode(notes),
      'sets': jsonEncode(sets),
    };
  }

  TrainingEntity toEntity() {
    return TrainingEntity(
      id: id,
      name: name,
      notes: notes,
      sets: sets,
    );
  }
}
