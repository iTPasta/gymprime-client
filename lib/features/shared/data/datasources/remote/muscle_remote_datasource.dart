import 'dart:convert';

import 'package:gymprime/core/errors/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:objectid/objectid.dart';

import 'package:gymprime/core/constants/constants.dart';
import 'package:gymprime/core/utils/headers.dart';
import 'package:gymprime/features/shared/data/models/muscle_model.dart';

abstract class MuscleRemoteDataSource {
  Future<(List<MuscleModel>, int)> getAllMuscles();
  Future<MuscleModel> getMuscle(ObjectId id);
  Future<(ObjectId, int)> createMuscle(MuscleModel muscle);
  Future<int> updateMuscle(MuscleModel muscle);
  Future<int> deleteMuscle(ObjectId id);
}

class MuscleRemoteDataSourceImpl implements MuscleRemoteDataSource {
  final http.Client client;
  final String routeName;

  MuscleRemoteDataSourceImpl({
    required this.client,
    required this.routeName,
  });

  @override
  Future<(List<MuscleModel>, int)> getAllMuscles() async {
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
      final List<Map<String, dynamic>> musclesJson = json['muscles'];
      final List<MuscleModel> muscles = [];
      for (Map<String, dynamic> muscleJson in musclesJson) {
        muscles.add(MuscleModel.fromJson(muscleJson));
      }
      final int musclesLastUpdate = json['musclesLastUpdate'];
      return (muscles, musclesLastUpdate);
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<MuscleModel> getMuscle(ObjectId id) async {
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
      final Map<String, dynamic> muscleJson = json['muscle'];
      final MuscleModel muscle = MuscleModel.fromJson(muscleJson);
      return muscle;
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<(ObjectId, int)> createMuscle(MuscleModel muscle) async {
    final response = await client.post(
      Uri.http(
        APIBaseURL,
        routeName,
      ),
      headers: generateHeaders(
        contentType: ContentType.json,
        authorization: true,
      ),
      body: jsonEncode(muscle),
    );
    if (response.statusCode == 201) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final ObjectId muscleId = ObjectId.fromHexString(json['muscleId']);
      final int musclesLastUpdate = json['musclesLastUpdate'];
      return (muscleId, musclesLastUpdate);
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<int> updateMuscle(MuscleModel muscle) async {
    final response = await client.put(
      Uri.http(
        APIBaseURL,
        '$routeName/${muscle.id.toString()}',
      ),
      headers: generateHeaders(
        contentType: ContentType.json,
        authorization: true,
      ),
      body: jsonEncode(muscle),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final int musclesLastUpdate = json['musclesLastUpdate'];
      return musclesLastUpdate;
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<int> deleteMuscle(ObjectId id) async {
    final response = await client.delete(
      Uri.http(
        APIBaseURL,
        '$routeName/${id.toString()}',
      ),
      headers: generateHeaders(contentType: null, authorization: true),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final int musclesLastUpdate = json['musclesLastUpdate'];
      return musclesLastUpdate;
    } else {
      throw ServerException(response: response);
    }
  }
}
