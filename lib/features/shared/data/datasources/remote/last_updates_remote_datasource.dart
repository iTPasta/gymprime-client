import 'dart:convert';

import 'package:gymprime/features/shared/data/models/last_updates_model.dart';

import 'package:http/http.dart' as http;

import 'package:gymprime/core/constants/constants.dart';
import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/core/utils/headers.dart';

abstract class LastUpdatesRemoteDataSource {
  Future<LastUpdatesModel> getLastUpdates();
  Future<LastUpdatesModel> getPublicLastUpdates();
  Future<LastUpdatesModel> getPrivateLastUpdates();
}

class LastUpdatesRemoteDataSourceImpl implements LastUpdatesRemoteDataSource {
  final http.Client client;
  final String routeName;

  LastUpdatesRemoteDataSourceImpl({
    required this.client,
    required this.routeName,
  });

  @override
  Future<LastUpdatesModel> getLastUpdates() async {
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
      return LastUpdatesModel.fromJson(json['lastUpdates']);
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<LastUpdatesModel> getPublicLastUpdates() async {
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
      return LastUpdatesModel.fromJson(json['publicLastUpdates']);
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<LastUpdatesModel> getPrivateLastUpdates() async {
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
      return LastUpdatesModel.fromJson(json['privateLastUpdates']);
    } else {
      throw ServerException(response: response);
    }
  }
}
