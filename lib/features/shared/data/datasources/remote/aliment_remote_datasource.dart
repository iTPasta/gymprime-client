import 'dart:convert';

import 'package:objectid/objectid.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:gymprime/core/constants/constants.dart';
import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/core/resources/headers.dart';
import 'package:gymprime/features/shared/data/models/aliment_model.dart';
import 'package:gymprime/injection_container.dart';

abstract class AlimentRemoteDataSource {
  Future<(List<AlimentModel>, int)> getAllAliments();
  Future<AlimentModel> getAliment(ObjectId id);
  Future<(AlimentModel, int)> createAliment(AlimentModel aliment);
  Future<int> updateAliment(AlimentModel aliment);
  Future<int> deleteAliment(ObjectId id);
}

class AlimentRemoteDataSourceImpl implements AlimentRemoteDataSource {
  final client = sl<http.Client>();
  final sharedPreferences = sl<SharedPreferences>();

  static const String routeName = 'aliments';

  @override
  Future<(List<AlimentModel>, int)> getAllAliments() async {
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
      final List<Map<String, dynamic>> alimentsJson = json['aliments'];
      final List<AlimentModel> aliments = [];
      for (Map<String, dynamic> alimentJson in alimentsJson) {
        aliments.add(AlimentModel.fromJson(alimentJson));
      }
      final int alimentsLastUpdate = json['alimentsLastUpdate'];
      return (aliments, alimentsLastUpdate);
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<AlimentModel> getAliment(ObjectId id) async {
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
      final Map<String, dynamic> alimentJson = json['aliment'];
      final AlimentModel aliment = AlimentModel.fromJson(alimentJson);
      return aliment;
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<(AlimentModel, int)> createAliment(AlimentModel aliment) async {
    final response = await client.post(
      Uri.http(
        APIBaseURL,
        routeName,
      ),
      headers: generateHeaders(
        contentType: ContentType.json,
        authorization: true,
      ),
      body: jsonEncode(aliment),
    );
    if (response.statusCode == 201) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final Map<String, dynamic> alimentJson = json['aliment'];
      final AlimentModel aliment = AlimentModel.fromJson(alimentJson);
      final int alimentsLastUpdate = json['alimentsLastUpdate'];
      return (aliment, alimentsLastUpdate);
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<int> updateAliment(AlimentModel aliment) async {
    final response = await client.put(
      Uri.http(
        APIBaseURL,
        '$routeName/${aliment.id.toString()}',
      ),
      headers: generateHeaders(
        contentType: ContentType.json,
        authorization: true,
      ),
      body: jsonEncode(aliment),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final int alimentsLastUpdate = json['alimentsLastUpdate'];
      return alimentsLastUpdate;
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<int> deleteAliment(ObjectId id) async {
    final response = await client.delete(
      Uri.http(
        APIBaseURL,
        '$routeName/${id.toString()}',
      ),
      headers: generateHeaders(contentType: null, authorization: true),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final int alimentsLastUpdate = json['alimentsLastUpdate'];
      return alimentsLastUpdate;
    } else {
      throw ServerException(response: response);
    }
  }
}
