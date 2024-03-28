import 'dart:convert';

import 'package:gymprime/core/errors/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:objectid/objectid.dart';

import 'package:gymprime/core/constants/constants.dart';
import 'package:gymprime/core/utils/headers.dart';
import 'package:gymprime/features/shared/data/models/muscle_group_model.dart';

abstract class MuscleGroupRemoteDataSource {
  Future<(List<MuscleGroupModel>, int)> getAllMuscleGroups();
  Future<MuscleGroupModel> getMuscleGroup(ObjectId id);
  Future<(ObjectId, int)> createMuscleGroup(MuscleGroupModel muscleGroup);
  Future<int> updateMuscleGroup(MuscleGroupModel muscleGroup);
  Future<int> deleteMuscleGroup(ObjectId id);
}

class MuscleGroupRemoteDataSourceImpl implements MuscleGroupRemoteDataSource {
  final http.Client client;
  final String routeName;

  MuscleGroupRemoteDataSourceImpl({
    required this.client,
    required this.routeName,
  });

  @override
  Future<(List<MuscleGroupModel>, int)> getAllMuscleGroups() async {
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
      final List<Map<String, dynamic>> muscleGroupsJson = json['muscleGroups'];
      final List<MuscleGroupModel> muscleGroups = [];
      for (Map<String, dynamic> muscleGroupJson in muscleGroupsJson) {
        muscleGroups.add(MuscleGroupModel.fromJson(muscleGroupJson));
      }
      final int muscleGroupsLastUpdate = json['muscleGroupsLastUpdate'];
      return (muscleGroups, muscleGroupsLastUpdate);
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<MuscleGroupModel> getMuscleGroup(ObjectId id) async {
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
      final Map<String, dynamic> muscleGroupJson = json['muscleGroup'];
      final MuscleGroupModel muscleGroup =
          MuscleGroupModel.fromJson(muscleGroupJson);
      return muscleGroup;
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<(ObjectId, int)> createMuscleGroup(
      MuscleGroupModel muscleGroup) async {
    final response = await client.post(
      Uri.http(
        APIBaseURL,
        routeName,
      ),
      headers: generateHeaders(
        contentType: ContentType.json,
        authorization: true,
      ),
      body: jsonEncode(muscleGroup),
    );
    if (response.statusCode == 201) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final ObjectId muscleGroupId =
          ObjectId.fromHexString(json['muscleGroupId']);
      final int muscleGroupsLastUpdate = json['muscleGroupsLastUpdate'];
      return (muscleGroupId, muscleGroupsLastUpdate);
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<int> updateMuscleGroup(MuscleGroupModel muscleGroup) async {
    final response = await client.put(
      Uri.http(
        APIBaseURL,
        '$routeName/${muscleGroup.id.toString()}',
      ),
      headers: generateHeaders(
        contentType: ContentType.json,
        authorization: true,
      ),
      body: jsonEncode(muscleGroup),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final int muscleGroupsLastUpdate = json['muscleGroupsLastUpdate'];
      return muscleGroupsLastUpdate;
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<int> deleteMuscleGroup(ObjectId id) async {
    final response = await client.delete(
      Uri.http(
        APIBaseURL,
        '$routeName/${id.toString()}',
      ),
      headers: generateHeaders(contentType: null, authorization: true),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final int muscleGroupsLastUpdate = json['muscleGroupsLastUpdate'];
      return muscleGroupsLastUpdate;
    } else {
      throw ServerException(response: response);
    }
  }
}
