import 'dart:convert';

import 'package:gymprime/core/constants/constants.dart';
import 'package:gymprime/features/shared/data/models/diet_model.dart';
import 'package:gymprime/injection_container.dart';
import 'package:objectid/objectid.dart';
import 'package:http/http.dart' as http;

abstract class DietRemoteDataSource {
  Future<List<DietModel>> getMyDiets();
  Future<DietModel> getDiet(ObjectId id);
  Future<DietModel> createDiet(DietModel diet);
  Future<DietModel> updateDiet(DietModel diet);
  Future<ObjectId> deleteDiet(ObjectId id);
}

class DietRemoteDataSourceImpl implements DietRemoteDataSource {
  final http.Client client = sl<http.Client>();

  @override
  Future<DietModel> createDiet(DietModel diet) async {
    try {
      final response = await client.post(
        Uri.http(APIBaseURL, 'diet'),
        body: {'name': 'doodle', 'color': 'blue'},
      );
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      var uri = Uri.parse(decodedResponse['uri'] as String);
      print(await client.get(uri));
    }
  }

  @override
  Future<ObjectId> deleteDiet(ObjectId id) {
    // TODO: implement deleteDiet
    throw UnimplementedError();
  }

  @override
  Future<DietModel> getDiet(ObjectId id) {
    // TODO: implement getDiet
    throw UnimplementedError();
  }

  @override
  Future<List<DietModel>> getMyDiets() {
    // TODO: implement getMyDiets
    throw UnimplementedError();
  }

  @override
  Future<DietModel> updateDiet(DietModel diet) {
    // TODO: implement updateDiet
    throw UnimplementedError();
  }
}
