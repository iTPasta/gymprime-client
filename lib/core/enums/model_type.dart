import 'package:gymprime/features/shared/data/models/action_model.dart';
import 'package:gymprime/features/shared/data/models/aliment_model.dart';
import 'package:gymprime/features/shared/data/models/diet_model.dart';
import 'package:gymprime/features/shared/data/models/exercise_model.dart';
import 'package:gymprime/features/shared/data/models/meal_model.dart';
import 'package:gymprime/features/shared/data/models/muscle_group_model.dart';
import 'package:gymprime/features/shared/data/models/muscle_model.dart';
import 'package:gymprime/features/shared/data/models/program_model.dart';
import 'package:gymprime/features/shared/data/models/recipe_model.dart';
import 'package:gymprime/features/shared/data/models/training_model.dart';
import 'package:gymprime/features/shared/domain/entities/action_entity.dart';
import 'package:gymprime/features/shared/domain/entities/aliment_entity.dart';
import 'package:gymprime/features/shared/domain/entities/diet_entity.dart';
import 'package:gymprime/features/shared/domain/entities/exercise_entity.dart';
import 'package:gymprime/features/shared/domain/entities/meal_entity.dart';
import 'package:gymprime/features/shared/domain/entities/muscle_entity.dart';
import 'package:gymprime/features/shared/domain/entities/muscle_group_entity.dart';
import 'package:gymprime/features/shared/domain/entities/program_entity.dart';
import 'package:gymprime/features/shared/domain/entities/recipe_entity.dart';
import 'package:gymprime/features/shared/domain/entities/training_entity.dart';

enum ModelType {
  action,
  aliment,
  diet,
  exercise,
  meal,
  muscleGroup,
  muscle,
  program,
  recipe,
  training,
}

extension ModelTypeExtension on ModelType {
  String toJson() {
    return toString();
  }

  static ModelType? fromJson(String json) {
    for (ModelType modelType in ModelType.values) {
      if (modelType.toString() == json) {
        return modelType;
      }
    }
    return null;
  }

  static ModelType? fromType(Type type) {
    switch (type) {
      case ActionEntity _ || ActionModel _:
        return ModelType.action;
      case AlimentEntity _ || AlimentModel _:
        return ModelType.aliment;
      case DietEntity _ || DietModel _:
        return ModelType.diet;
      case ExerciseEntity _ || ExerciseModel _:
        return ModelType.exercise;
      case MealEntity _ || MealModel _:
        return ModelType.meal;
      case MuscleGroupEntity _ || MuscleGroupModel _:
        return ModelType.muscleGroup;
      case MuscleEntity _ || MuscleModel _:
        return ModelType.muscle;
      case ProgramEntity _ || ProgramModel _:
        return ModelType.program;
      case RecipeEntity _ || RecipeModel _:
        return ModelType.recipe;
      case TrainingEntity _ || TrainingModel _:
        return ModelType.training;
      default:
        return null;
    }
  }
}
