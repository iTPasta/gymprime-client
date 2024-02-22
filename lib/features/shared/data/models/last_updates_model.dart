import 'dart:convert';

import 'package:gymprime/features/shared/domain/entities/last_updates_entity.dart';

class LastUpdatesModel extends LastUpdatesEntity {
  const LastUpdatesModel({
    super.preferencesLastUpdate,
    super.dietsLastUpdate,
    super.mealsLastUpdate,
    super.recipesLastUpdate,
    super.programsLastUpdate,
    super.trainingsLastUpdate,
    super.alimentsLastUpdate,
    super.exercisesLastUpdate,
    super.muscleGroupsLastUpdate,
    super.musclesLastUpdate,
  });

  factory LastUpdatesModel.fromJson(Map<String, dynamic> map) {
    return LastUpdatesModel(
      preferencesLastUpdate: map["preferencesLastUpdate"],
      dietsLastUpdate: map["dietsLastUpdate"],
      mealsLastUpdate: map["mealsLastUpdate"],
      recipesLastUpdate: map["recipesLastUpdate"],
      programsLastUpdate: map["programsLastUpdate"],
      trainingsLastUpdate: map["trainingsLastUpdate"],
      alimentsLastUpdate: map["alimentsLastUpdate"],
      exercisesLastUpdate: map["exercisesLastUpdate"],
      muscleGroupsLastUpdate: map["muscleGroupsLastUpdate"],
      musclesLastUpdate: map["musclesLastUpdate"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'preferencesLastUpdate': jsonEncode(preferencesLastUpdate),
      'dietsLastUpdate': jsonEncode(dietsLastUpdate),
      'mealsLastUpdate': jsonEncode(mealsLastUpdate),
      'recipesLastUpdate': jsonEncode(recipesLastUpdate),
      'programsLastUpdate': jsonEncode(programsLastUpdate),
      'trainingsLastUpdate': jsonEncode(trainingsLastUpdate),
      'alimentsLastUpdate': jsonEncode(alimentsLastUpdate),
      'exercisesLastUpdate': jsonEncode(exercisesLastUpdate),
      'muscleGroupsLastUpdate': jsonEncode(muscleGroupsLastUpdate),
      'musclesLastUpdate': jsonEncode(musclesLastUpdate),
    };
  }

  LastUpdatesEntity toEntity() {
    return LastUpdatesEntity(
      preferencesLastUpdate: preferencesLastUpdate,
      dietsLastUpdate: dietsLastUpdate,
      mealsLastUpdate: mealsLastUpdate,
      recipesLastUpdate: recipesLastUpdate,
      programsLastUpdate: programsLastUpdate,
      trainingsLastUpdate: trainingsLastUpdate,
      alimentsLastUpdate: alimentsLastUpdate,
      exercisesLastUpdate: exercisesLastUpdate,
      muscleGroupsLastUpdate: muscleGroupsLastUpdate,
      musclesLastUpdate: musclesLastUpdate,
    );
  }
}
