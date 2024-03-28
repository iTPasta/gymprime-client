import 'dart:convert';

import 'package:gymprime/core/errors/exceptions.dart';
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
import 'package:http/http.dart' as http;

import 'package:gymprime/core/constants/constants.dart';
import 'package:gymprime/core/utils/headers.dart';

abstract class DataRemoteDataSource {
  Future<
      (
        LastUpdatesModel,
        PreferencesModel,
        List<DietModel>,
        List<MealModel>,
        List<RecipeModel>,
        List<ProgramModel>,
        List<TrainingModel>,
        List<ExerciseModel>,
        List<MuscleModel>,
        List<MuscleGroupModel>,
      )> getAllData();

  Future<
      (
        PreferencesModel?,
        List<DietModel>?,
        List<MealModel>?,
        List<RecipeModel>?,
        List<ProgramModel>?,
        List<TrainingModel>?,
        List<ExerciseModel>?,
        List<MuscleModel>?,
        List<MuscleGroupModel>?,
      )> getSomeData({
    required bool wantPreferences,
    required bool wantDiets,
    required bool wantMeals,
    required bool wantRecipes,
    required bool wantPrograms,
    required bool wantTrainings,
    required bool wantExercises,
    required bool wantMuscles,
    required bool wantMuscleGroups,
  });

  Future<
      (
        LastUpdatesModel,
        List<ExerciseModel>,
        List<MuscleModel>,
        List<MuscleGroupModel>,
      )> getPublicData();

  Future<
      (
        LastUpdatesModel,
        PreferencesModel,
        List<DietModel>,
        List<MealModel>,
        List<RecipeModel>,
        List<ProgramModel>,
        List<TrainingModel>,
      )> getPrivateData();
}

class DataRemoteDataSourceImpl implements DataRemoteDataSource {
  final http.Client client;
  final String routeName;

  DataRemoteDataSourceImpl({
    required this.client,
    required this.routeName,
  });

  @override
  Future<
      (
        LastUpdatesModel,
        PreferencesModel,
        List<DietModel>,
        List<MealModel>,
        List<RecipeModel>,
        List<ProgramModel>,
        List<TrainingModel>,
        List<ExerciseModel>,
        List<MuscleModel>,
        List<MuscleGroupModel>,
      )> getAllData() async {
    final response = await client.get(
      Uri.http(
        APIBaseURL,
        '$routeName/all',
      ),
      headers: generateHeaders(
        contentType: null,
        authorization: true,
      ),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return (
        LastUpdatesModel.fromJson(json['lastUpdates']),
        PreferencesModel.fromJson(json['preferences']),
        DietModel.fromJsonToList(json['diets']),
        MealModel.fromJsonToList(json['meals']),
        RecipeModel.fromJsonToList(json['recipes']),
        ProgramModel.fromJsonToList(json['programs']),
        TrainingModel.fromJsonToList(json['trainings']),
        ExerciseModel.fromJsonToList(json['exercises']),
        MuscleModel.fromJsonToList(json['muscles']),
        MuscleGroupModel.fromJsonToList(json['muscleGroups']),
      );
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<
      (
        PreferencesModel?,
        List<DietModel>?,
        List<MealModel>?,
        List<RecipeModel>?,
        List<ProgramModel>?,
        List<TrainingModel>?,
        List<ExerciseModel>?,
        List<MuscleModel>?,
        List<MuscleGroupModel>?,
      )> getSomeData({
    required bool wantPreferences,
    required bool wantDiets,
    required bool wantMeals,
    required bool wantRecipes,
    required bool wantPrograms,
    required bool wantTrainings,
    required bool wantExercises,
    required bool wantMuscles,
    required bool wantMuscleGroups,
  }) async {
    final Map<String, dynamic> queryParameters = {};
    final List<String> wantedData = [];
    if (wantPreferences) wantedData.add('preferences');
    if (wantDiets) wantedData.add('diets');
    if (wantMeals) wantedData.add('meals');
    if (wantRecipes) wantedData.add('recipes');
    if (wantPrograms) wantedData.add('programs');
    if (wantTrainings) wantedData.add('trainings');
    if (wantExercises) wantedData.add('exercises');
    if (wantMuscles) wantedData.add('muscles');
    if (wantMuscleGroups) wantedData.add('muscleGroups');
    queryParameters['data'] = wantedData;

    final response = await client.get(
      Uri.http(
        APIBaseURL,
        '$routeName/some',
        queryParameters,
      ),
      headers: generateHeaders(
        contentType: null,
        authorization: true,
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return (
        json['preferences'] != null
            ? PreferencesModel.fromJson(json['preferences'])
            : null,
        json['diets'] != null ? DietModel.fromJsonToList(json['diets']) : null,
        json['meals'] != null ? MealModel.fromJsonToList(json['meals']) : null,
        json['recipes'] != null
            ? RecipeModel.fromJsonToList(json['recipes'])
            : null,
        json['programs'] != null
            ? ProgramModel.fromJsonToList(json['programs'])
            : null,
        json['trainings'] != null
            ? TrainingModel.fromJsonToList(json['trainings'])
            : null,
        json['exercises'] != null
            ? ExerciseModel.fromJsonToList(json['exercises'])
            : null,
        json['muscles'] != null
            ? MuscleModel.fromJsonToList(json['muscles'])
            : null,
        json['muscleGroups'] != null
            ? MuscleGroupModel.fromJsonToList(json['muscleGroups'])
            : null,
      );
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<
      (
        LastUpdatesModel,
        List<ExerciseModel>,
        List<MuscleModel>,
        List<MuscleGroupModel>,
      )> getPublicData() async {
    final response = await client.get(
      Uri.http(
        APIBaseURL,
        '$routeName/public',
      ),
      headers: generateHeaders(
        contentType: null,
        authorization: true,
      ),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return (
        LastUpdatesModel.fromJson(json['publicLastUpdates']),
        ExerciseModel.fromJsonToList(json['exercises']),
        MuscleModel.fromJsonToList(json['muscles']),
        MuscleGroupModel.fromJsonToList(json['muscleGroups']),
      );
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<
      (
        LastUpdatesModel,
        PreferencesModel,
        List<DietModel>,
        List<MealModel>,
        List<RecipeModel>,
        List<ProgramModel>,
        List<TrainingModel>,
      )> getPrivateData() async {
    final response = await client.get(
      Uri.http(
        APIBaseURL,
        '$routeName/all',
      ),
      headers: generateHeaders(
        contentType: null,
        authorization: true,
      ),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return (
        LastUpdatesModel.fromJson(json['privateLastUpdates']),
        PreferencesModel.fromJson(json['preferences']),
        DietModel.fromJsonToList(json['diets']),
        MealModel.fromJsonToList(json['meals']),
        RecipeModel.fromJsonToList(json['recipes']),
        ProgramModel.fromJsonToList(json['programs']),
        TrainingModel.fromJsonToList(json['trainings']),
      );
    } else {
      throw ServerException(response: response);
    }
  }
}
