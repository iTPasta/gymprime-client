import 'package:gymprime/features/shared/data/models/last_updates_model.dart';

class LastUpdatesEntity {
  final int? preferencesLastUpdate;
  final int? dietsLastUpdate;
  final int? mealsLastUpdate;
  final int? recipesLastUpdate;
  final int? programsLastUpdate;
  final int? trainingsLastUpdate;
  final int? alimentsLastUpdate;
  final int? exercisesLastUpdate;
  final int? muscleGroupsLastUpdate;
  final int? musclesLastUpdate;

  const LastUpdatesEntity({
    this.preferencesLastUpdate,
    this.dietsLastUpdate,
    this.mealsLastUpdate,
    this.recipesLastUpdate,
    this.programsLastUpdate,
    this.trainingsLastUpdate,
    this.alimentsLastUpdate,
    this.exercisesLastUpdate,
    this.muscleGroupsLastUpdate,
    this.musclesLastUpdate,
  });

  List<Object?> get props {
    return [
      preferencesLastUpdate,
      dietsLastUpdate,
      mealsLastUpdate,
      recipesLastUpdate,
      programsLastUpdate,
      trainingsLastUpdate,
      alimentsLastUpdate,
      exercisesLastUpdate,
      muscleGroupsLastUpdate,
      musclesLastUpdate,
    ];
  }

  LastUpdatesModel toModel() {
    return LastUpdatesModel(
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
