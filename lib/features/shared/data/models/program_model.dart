import 'dart:convert';

import 'package:gymprime/features/shared/domain/entities/program_entity.dart';

class ProgramModel extends ProgramEntity {
  const ProgramModel({
    required super.id,
    super.name,
    super.description,
    required super.exercises,
    required super.trainings,
    required super.goal,
  });

  factory ProgramModel.fromJson(Map<String, dynamic> map) {
    return ProgramModel(
      id: map['_id'] ?? map['id'],
      name: map['name'],
      description: map['description'],
      exercises: map['exercises'] ?? [],
      trainings: map['trainings'] ?? [],
      goal: map['goal'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': jsonEncode(id),
      'name': jsonEncode(name),
      'description': jsonEncode(description),
      'exercises': jsonEncode(exercises),
      'trainings': jsonEncode(trainings),
      'goal': jsonEncode(goal)
    };
  }

  ProgramEntity toEntity() {
    return ProgramEntity(
      id: id,
      name: name,
      description: description,
      exercises: exercises,
      trainings: trainings,
      goal: goal,
    );
  }
}
