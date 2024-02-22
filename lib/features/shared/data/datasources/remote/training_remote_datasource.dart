import 'dart:convert';

import 'package:objectid/objectid.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:gymprime/core/constants/constants.dart';
import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/core/resources/headers.dart';
import 'package:gymprime/features/shared/data/models/training_model.dart';
import 'package:gymprime/injection_container.dart';

abstract class TrainingRemoteDataSource {
  Future<List<TrainingModel>> getAllTrainings();
  Future<(List<TrainingModel>, int)> getMyTrainings();
  Future<TrainingModel> getTraining(ObjectId id);
  Future<(TrainingModel, int)> createTraining(TrainingModel training);
  Future<int> updateTraining(TrainingModel training);
  Future<int> deleteTraining(ObjectId id);
}

class TrainingRemoteDataSourceImpl implements TrainingRemoteDataSource {
  final client = sl<http.Client>();
  final sharedPreferences = sl<SharedPreferences>();

  static const String routeName = 'trainings';

  @override
  Future<List<TrainingModel>> getAllTrainings() async {
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
      final List<Map<String, dynamic>> trainingsJson = json['trainings'];
      final List<TrainingModel> trainings = [];
      for (Map<String, dynamic> trainingJson in trainingsJson) {
        trainings.add(TrainingModel.fromJson(trainingJson));
      }
      return trainings;
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<(List<TrainingModel>, int)> getMyTrainings() async {
    final response = await client.get(
      Uri.http(
        APIBaseURL,
        routeName,
      ),
      headers: generateHeaders(
        contentType: null,
        authorization: true,
      ),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final List<Map<String, dynamic>> trainingsJson = json['trainings'];
      final List<TrainingModel> trainings = [];
      for (Map<String, dynamic> trainingJson in trainingsJson) {
        trainings.add(TrainingModel.fromJson(trainingJson));
      }
      final int trainingsLastUpdate = json['trainingsLastUpdate'];
      return (trainings, trainingsLastUpdate);
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<TrainingModel> getTraining(ObjectId id) async {
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
      final Map<String, dynamic> trainingJson = json['training'];
      final TrainingModel training = TrainingModel.fromJson(trainingJson);
      return training;
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<(TrainingModel, int)> createTraining(TrainingModel training) async {
    final response = await client.post(
      Uri.http(
        APIBaseURL,
        routeName,
      ),
      headers: generateHeaders(
        contentType: ContentType.json,
        authorization: true,
      ),
      body: jsonEncode(training),
    );
    if (response.statusCode == 201) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final Map<String, dynamic> trainingJson = json['training'];
      final TrainingModel training = TrainingModel.fromJson(trainingJson);
      final int trainingsLastUpdate = json['trainingsLastUpdate'];
      return (training, trainingsLastUpdate);
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<int> updateTraining(TrainingModel training) async {
    final response = await client.put(
      Uri.http(
        APIBaseURL,
        '$routeName/${training.id.toString()}',
      ),
      headers: generateHeaders(
        contentType: ContentType.json,
        authorization: true,
      ),
      body: jsonEncode(training),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final int trainingsLastUpdate = json['trainingsLastUpdate'];
      return trainingsLastUpdate;
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<int> deleteTraining(ObjectId id) async {
    final response = await client.delete(
      Uri.http(
        APIBaseURL,
        '$routeName/${id.toString()}',
      ),
      headers: generateHeaders(contentType: null, authorization: true),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final int trainingsLastUpdate = json['trainingsLastUpdate'];
      return trainingsLastUpdate;
    } else {
      throw ServerException(response: response);
    }
  }
}
