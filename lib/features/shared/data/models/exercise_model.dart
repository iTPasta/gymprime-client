import 'dart:convert';

import 'package:gymprime/features/shared/domain/entities/exercise_entity.dart';
import 'package:objectid/objectid.dart';

class ExerciseModel extends ExerciseEntity {
  const ExerciseModel({
    required super.id,
    required super.names,
    required super.descriptions,
    required super.muscles,
    super.muscleGroup,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> map) {
    return ExerciseModel(
      id: map['_id'] != null
          ? ObjectId.fromHexString(map['_id'])
          : ObjectId.fromHexString(map['id']),
      names: map['names'] ?? {},
      descriptions: map['descriptions'] ?? {},
      muscles: map['muscles'] ?? [],
      muscleGroup: map['muscleGroup'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': jsonEncode(id),
      'names': jsonEncode(names),
      'descriptions': jsonEncode(descriptions),
      'muscles': jsonEncode(muscles),
      'muscleGroup': jsonEncode(muscleGroup),
    };
  }

  ExerciseEntity toEntity() {
    return ExerciseEntity(
      id: id,
      names: names,
      descriptions: descriptions,
      muscles: muscles,
      muscleGroup: muscleGroup,
    );
  }

  static List<ExerciseModel> fromJsonToList(
    List<Map<String, dynamic>> jsonExercises,
  ) {
    final List<ExerciseModel> exercisesList = [];
    for (final jsonExercise in jsonExercises) {
      exercisesList.add(ExerciseModel.fromJson(jsonExercise));
    }
    return exercisesList;
  }
}
