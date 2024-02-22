import 'dart:convert';

import 'package:objectid/objectid.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:gymprime/core/constants/constants.dart';
import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/core/resources/headers.dart';
import 'package:gymprime/features/shared/data/models/program_model.dart';
import 'package:gymprime/injection_container.dart';

abstract class ProgramRemoteDataSource {
  Future<List<ProgramModel>> getAllPrograms();
  Future<(List<ProgramModel>, int)> getMyPrograms();
  Future<ProgramModel> getProgram(ObjectId id);
  Future<(ProgramModel, int)> createProgram(ProgramModel program);
  Future<int> updateProgram(ProgramModel program);
  Future<int> deleteProgram(ObjectId id);
}

class ProgramRemoteDataSourceImpl implements ProgramRemoteDataSource {
  final client = sl<http.Client>();
  final sharedPreferences = sl<SharedPreferences>();

  static const String routeName = 'programs';

  @override
  Future<List<ProgramModel>> getAllPrograms() async {
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
      final List<Map<String, dynamic>> programsJson = json['programs'];
      final List<ProgramModel> programs = [];
      for (Map<String, dynamic> programJson in programsJson) {
        programs.add(ProgramModel.fromJson(programJson));
      }
      return programs;
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<(List<ProgramModel>, int)> getMyPrograms() async {
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
      final List<Map<String, dynamic>> programsJson = json['programs'];
      final List<ProgramModel> programs = [];
      for (Map<String, dynamic> programJson in programsJson) {
        programs.add(ProgramModel.fromJson(programJson));
      }
      final int programsLastUpdate = json['programsLastUpdate'];
      return (programs, programsLastUpdate);
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<ProgramModel> getProgram(ObjectId id) async {
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
      final Map<String, dynamic> programJson = json['program'];
      final ProgramModel program = ProgramModel.fromJson(programJson);
      return program;
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<(ProgramModel, int)> createProgram(ProgramModel program) async {
    final response = await client.post(
      Uri.http(
        APIBaseURL,
        routeName,
      ),
      headers: generateHeaders(
        contentType: ContentType.json,
        authorization: true,
      ),
      body: jsonEncode(program),
    );
    if (response.statusCode == 201) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final Map<String, dynamic> programJson = json['program'];
      final ProgramModel program = ProgramModel.fromJson(programJson);
      final int programsLastUpdate = json['programsLastUpdate'];
      return (program, programsLastUpdate);
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<int> updateProgram(ProgramModel program) async {
    final response = await client.put(
      Uri.http(
        APIBaseURL,
        '$routeName/${program.id.toString()}',
      ),
      headers: generateHeaders(
        contentType: ContentType.json,
        authorization: true,
      ),
      body: jsonEncode(program),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final int programsLastUpdate = json['programsLastUpdate'];
      return programsLastUpdate;
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<int> deleteProgram(ObjectId id) async {
    final response = await client.delete(
      Uri.http(
        APIBaseURL,
        '$routeName/${id.toString()}',
      ),
      headers: generateHeaders(contentType: null, authorization: true),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final int programsLastUpdate = json['programsLastUpdate'];
      return programsLastUpdate;
    } else {
      throw ServerException(response: response);
    }
  }
}
