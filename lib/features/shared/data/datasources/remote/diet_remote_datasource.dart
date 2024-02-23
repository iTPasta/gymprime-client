import 'dart:convert';

import 'package:objectid/objectid.dart';
import 'package:http/http.dart' as http;

import 'package:gymprime/core/constants/constants.dart';
import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/core/utils/headers.dart';
import 'package:gymprime/features/shared/data/models/diet_model.dart';

abstract class DietRemoteDataSource {
  Future<List<DietModel>> getAllDiets();
  Future<(List<DietModel>, int)> getMyDiets();
  Future<DietModel> getDiet(ObjectId id);
  Future<(DietModel, int)> createDiet(DietModel diet);
  Future<int> updateDiet(DietModel diet);
  Future<int> deleteDiet(ObjectId id);
}

class DietRemoteDataSourceImpl implements DietRemoteDataSource {
  final http.Client client;
  final String routeName;

  DietRemoteDataSourceImpl({
    required this.client,
    required this.routeName,
  });

  @override
  Future<List<DietModel>> getAllDiets() async {
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
      final List<Map<String, dynamic>> dietsJson = json['diets'];
      final List<DietModel> diets = [];
      for (Map<String, dynamic> dietJson in dietsJson) {
        diets.add(DietModel.fromJson(dietJson));
      }
      return diets;
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<(List<DietModel>, int)> getMyDiets() async {
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
      final List<Map<String, dynamic>> dietsJson = json['diets'];
      final List<DietModel> diets = [];
      for (Map<String, dynamic> dietJson in dietsJson) {
        diets.add(DietModel.fromJson(dietJson));
      }
      final int dietsLastUpdate = json['dietsLastUpdate'];
      return (diets, dietsLastUpdate);
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<DietModel> getDiet(ObjectId id) async {
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
      final Map<String, dynamic> dietJson = json['diet'];
      final DietModel diet = DietModel.fromJson(dietJson);
      return diet;
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<(DietModel, int)> createDiet(DietModel diet) async {
    final response = await client.post(
      Uri.http(
        APIBaseURL,
        routeName,
      ),
      headers: generateHeaders(
        contentType: ContentType.json,
        authorization: true,
      ),
      body: jsonEncode(diet),
    );
    if (response.statusCode == 201) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final Map<String, dynamic> dietJson = json['diet'];
      final DietModel diet = DietModel.fromJson(dietJson);
      final int dietsLastUpdate = json['dietsLastUpdate'];
      return (diet, dietsLastUpdate);
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<int> updateDiet(DietModel diet) async {
    final response = await client.put(
      Uri.http(
        APIBaseURL,
        '$routeName/${diet.id.toString()}',
      ),
      headers: generateHeaders(
        contentType: ContentType.json,
        authorization: true,
      ),
      body: jsonEncode(diet),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final int dietsLastUpdate = json['dietsLastUpdate'];
      return dietsLastUpdate;
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<int> deleteDiet(ObjectId id) async {
    final response = await client.delete(
      Uri.http(
        APIBaseURL,
        '$routeName/${id.toString()}',
      ),
      headers: generateHeaders(contentType: null, authorization: true),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final int dietsLastUpdate = json['dietsLastUpdate'];
      return dietsLastUpdate;
    } else {
      throw ServerException(response: response);
    }
  }
}
