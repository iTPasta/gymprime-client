import 'dart:convert';

import 'package:gymprime/features/shared/domain/entities/muscle_entity.dart';

class MuscleModel extends MuscleEntity {
  const MuscleModel({
    required super.id,
    required super.names,
    required super.descriptions,
    required super.exercises,
    super.muscleGroup,
  });

  factory MuscleModel.fromJson(Map<String, dynamic> map) {
    return MuscleModel(
      id: map['_id'] ?? map['id'],
      names: map['names'] ?? {},
      descriptions: map['descriptions'] ?? {},
      exercises: map['exercises'] ?? [],
      muscleGroup: map['muscleGroup'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': jsonEncode(id),
      'names': jsonEncode(names),
      'descriptions': jsonEncode(descriptions),
      'exercises': jsonEncode(exercises),
      'muscleGroup': jsonEncode(muscleGroup),
    };
  }

  MuscleEntity toEntity() {
    return MuscleEntity(
      id: id,
      names: names,
      descriptions: descriptions,
      exercises: exercises,
      muscleGroup: muscleGroup,
    );
  }
}
