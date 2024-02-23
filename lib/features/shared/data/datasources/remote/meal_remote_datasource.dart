import 'dart:convert';

import 'package:objectid/objectid.dart';
import 'package:http/http.dart' as http;

import 'package:gymprime/core/constants/constants.dart';
import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/core/utils/headers.dart';
import 'package:gymprime/features/shared/data/models/meal_model.dart';

abstract class MealRemoteDataSource {
  Future<List<MealModel>> getAllMeals();
  Future<(List<MealModel>, int)> getMyMeals();
  Future<MealModel> getMeal(ObjectId id);
  Future<(MealModel, int)> createMeal(MealModel meal);
  Future<int> updateMeal(MealModel meal);
  Future<int> deleteMeal(ObjectId id);
}

class MealRemoteDataSourceImpl implements MealRemoteDataSource {
  final http.Client client;
  final String routeName;

  MealRemoteDataSourceImpl({
    required this.client,
    required this.routeName,
  });

  @override
  Future<List<MealModel>> getAllMeals() async {
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
      final List<Map<String, dynamic>> mealsJson = json['meals'];
      final List<MealModel> meals = [];
      for (Map<String, dynamic> mealJson in mealsJson) {
        meals.add(MealModel.fromJson(mealJson));
      }
      return meals;
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<(List<MealModel>, int)> getMyMeals() async {
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
      final List<Map<String, dynamic>> mealsJson = json['meals'];
      final List<MealModel> meals = [];
      for (Map<String, dynamic> mealJson in mealsJson) {
        meals.add(MealModel.fromJson(mealJson));
      }
      final int mealsLastUpdate = json['mealsLastUpdate'];
      return (meals, mealsLastUpdate);
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<MealModel> getMeal(ObjectId id) async {
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
      final Map<String, dynamic> mealJson = json['meal'];
      final MealModel meal = MealModel.fromJson(mealJson);
      return meal;
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<(MealModel, int)> createMeal(MealModel meal) async {
    final response = await client.post(
      Uri.http(
        APIBaseURL,
        routeName,
      ),
      headers: generateHeaders(
        contentType: ContentType.json,
        authorization: true,
      ),
      body: jsonEncode(meal),
    );
    if (response.statusCode == 201) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final Map<String, dynamic> mealJson = json['meal'];
      final MealModel meal = MealModel.fromJson(mealJson);
      final int mealsLastUpdate = json['mealsLastUpdate'];
      return (meal, mealsLastUpdate);
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<int> updateMeal(MealModel meal) async {
    final response = await client.put(
      Uri.http(
        APIBaseURL,
        '$routeName/${meal.id.toString()}',
      ),
      headers: generateHeaders(
        contentType: ContentType.json,
        authorization: true,
      ),
      body: jsonEncode(meal),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final int mealsLastUpdate = json['mealsLastUpdate'];
      return mealsLastUpdate;
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<int> deleteMeal(ObjectId id) async {
    final response = await client.delete(
      Uri.http(
        APIBaseURL,
        '$routeName/${id.toString()}',
      ),
      headers: generateHeaders(contentType: null, authorization: true),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final int mealsLastUpdate = json['mealsLastUpdate'];
      return mealsLastUpdate;
    } else {
      throw ServerException(response: response);
    }
  }
}
