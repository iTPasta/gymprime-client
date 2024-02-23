import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:objectid/objectid.dart';

import 'package:gymprime/core/constants/constants.dart';
import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/core/utils/headers.dart';
import 'package:gymprime/features/shared/data/models/exercise_model.dart';

abstract class ExerciseRemoteDataSource {
  Future<(List<ExerciseModel>, int)> getAllExercises();
  Future<ExerciseModel> getExercise(ObjectId id);
  Future<(ExerciseModel, int)> createExercise(ExerciseModel exercise);
  Future<int> updateExercise(ExerciseModel exercise);
  Future<int> deleteExercise(ObjectId id);
}

class ExerciseRemoteDataSourceImpl implements ExerciseRemoteDataSource {
  final http.Client client;
  final String routeName;

  ExerciseRemoteDataSourceImpl({
    required this.client,
    required this.routeName,
  });
  @override
  Future<(List<ExerciseModel>, int)> getAllExercises() async {
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
      final List<Map<String, dynamic>> exercisesJson = json['exercises'];
      final List<ExerciseModel> exercises = [];
      for (Map<String, dynamic> exerciseJson in exercisesJson) {
        exercises.add(ExerciseModel.fromJson(exerciseJson));
      }
      final int exercisesLastUpdate = json['exercisesLastUpdate'];
      return (exercises, exercisesLastUpdate);
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<ExerciseModel> getExercise(ObjectId id) async {
    final response = await client.get(
      Uri.http(
        APIBaseURL,
        '$routeName/${id.toString()}',
      ),
      headers: generateHeaders(
        contentType: null,
        authorization: true,
      ),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final Map<String, dynamic> exerciseJson = json['exercise'];
      final ExerciseModel exercise = ExerciseModel.fromJson(exerciseJson);
      return exercise;
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<(ExerciseModel, int)> createExercise(ExerciseModel exercise) async {
    final response = await client.post(
      Uri.http(
        APIBaseURL,
        routeName,
      ),
      headers: generateHeaders(
        contentType: ContentType.json,
        authorization: true,
      ),
      body: jsonEncode(exercise),
    );
    if (response.statusCode == 201) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final Map<String, dynamic> exerciseJson = json['exercise'];
      final ExerciseModel exercise = ExerciseModel.fromJson(exerciseJson);
      final int exercisesLastUpdate = json['exercisesLastUpdate'];
      return (exercise, exercisesLastUpdate);
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<int> updateExercise(ExerciseModel exercise) async {
    final response = await client.put(
      Uri.http(
        APIBaseURL,
        '$routeName/${exercise.id.toString()}',
      ),
      headers: generateHeaders(
        contentType: ContentType.json,
        authorization: true,
      ),
      body: jsonEncode(exercise),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final int exercisesLastUpdate = json['exercisesLastUpdate'];
      return exercisesLastUpdate;
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<int> deleteExercise(ObjectId id) async {
    final response = await client.delete(
      Uri.http(
        APIBaseURL,
        '$routeName/${id.toString()}',
      ),
      headers: generateHeaders(contentType: null, authorization: true),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final int exercisesLastUpdate = json['exercisesLastUpdate'];
      return exercisesLastUpdate;
    } else {
      throw ServerException(response: response);
    }
  }
}
