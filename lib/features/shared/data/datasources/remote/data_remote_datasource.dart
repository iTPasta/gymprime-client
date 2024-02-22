import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:gymprime/core/constants/constants.dart';
import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/core/resources/headers.dart';
import 'package:gymprime/features/shared/data/models/diet_model.dart';

abstract class DataRemoteDataSource {
  Future<Map<Type, List<dynamic>>> getAllData();
  Future<Map<Type, List<dynamic>>> getSomeData();
  Future<Map<Type, List<dynamic>>> getPublicData();
  Future<Map<Type, List<dynamic>>> getPrivateData();
}

class DataRemoteDataSourceImpl implements DataRemoteDataSource {
  final http.Client client;
  final String routeName;

  DataRemoteDataSourceImpl({
    required this.client,
    required this.routeName,
  });

  @override
  Future<List<DietModel>> getAllData() async {
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
  Future<Map<Type, List>> getSomeData() {
    // TODO: implement getSomeData
    throw UnimplementedError();
  }

  @override
  Future<Map<Type, List>> getPublicData() {
    // TODO: implement getPublicData
    throw UnimplementedError();
  }

  @override
  Future<Map<Type, List>> getPrivateData() {
    // TODO: implement getPrivateData
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> _parseAllData(Map<String, dynamic> json) {
    final Map<String, dynamic> map = {};
    for (final key in json.keys) {
      final dynamic value;
      switch (key) {
        case "lastUpdates":
          value = json["lastUpdates"] as Map<String, int>;
          break;
        default:
          value = null;
          break;
      }
      map[key] = value;
    }
    return map;
  }
}
