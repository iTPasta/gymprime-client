import 'package:gymprime/features/shared/data/models/diet_model.dart';
import 'package:gymprime/features/shared/data/models/exercise_model.dart';
import 'package:gymprime/features/shared/data/models/last_updates_model.dart';
import 'package:gymprime/features/shared/data/models/meal_model.dart';
import 'package:gymprime/features/shared/data/models/muscle_group_model.dart';
import 'package:gymprime/features/shared/data/models/muscle_model.dart';
import 'package:gymprime/features/shared/data/models/preferences_model.dart';
import 'package:gymprime/features/shared/data/models/program_model.dart';
import 'package:gymprime/features/shared/data/models/recipe_model.dart';
import 'package:gymprime/features/shared/data/models/training_model.dart';

Map<String, dynamic> parseAllData(Map<String, dynamic> json) {
  final Map<String, dynamic> map = {};
  for (final key in json.keys) {
    final dynamic value;
    switch (key) {
      case "lastUpdates":
        value = LastUpdatesModel.fromJson(json[key]);
        break;
      case "preferences":
        value = PreferencesModel.fromJson(json[key]);
        break;
      case "diets":
        final List<DietModel> diets = [];
        for (final Map<String, dynamic> jsonDiet in json[key]) {
          diets.add(DietModel.fromJson(jsonDiet));
        }
        value = diets;
        break;
      case "meals":
        final List<MealModel> meals = [];
        for (final Map<String, dynamic> jsonMeal in json[key]) {
          meals.add(MealModel.fromJson(jsonMeal));
        }
        value = meals;
        break;
      case "recipes":
        final List<RecipeModel> recipes = [];
        for (final Map<String, dynamic> jsonRecipe in json[key]) {
          recipes.add(RecipeModel.fromJson(jsonRecipe));
        }
        value = recipes;
        break;
      case "programs":
        final List<ProgramModel> programs = [];
        for (final Map<String, dynamic> jsonProgram in json[key]) {
          programs.add(ProgramModel.fromJson(jsonProgram));
        }
        value = programs;
        break;
      case "trainings":
        final List<TrainingModel> trainings = [];
        for (final Map<String, dynamic> jsonTraining in json[key]) {
          trainings.add(TrainingModel.fromJson(jsonTraining));
        }
        value = trainings;
        break;
      case "exercises":
        final List<ExerciseModel> exercises = [];
        for (final Map<String, dynamic> jsonExercise in json[key]) {
          exercises.add(ExerciseModel.fromJson(jsonExercise));
        }
        value = exercises;
        break;
      case "muscles":
        final List<MuscleModel> muscles = [];
        for (final Map<String, dynamic> jsonMuscle in json[key]) {
          muscles.add(MuscleModel.fromJson(jsonMuscle));
        }
        value = muscles;
        break;
      case "muscleGroups":
        final List<MuscleGroupModel> muscleGroups = [];
        for (final Map<String, dynamic> jsonMuscleGroup in json[key]) {
          muscleGroups.add(MuscleGroupModel.fromJson(jsonMuscleGroup));
        }
        value = muscleGroups;
        break;
      default:
        value = null;
        break;
    }
    map[key] = value;
  }
  return map;
}

List<T extends 