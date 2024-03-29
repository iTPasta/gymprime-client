import 'dart:convert';

import 'package:gymprime/core/errors/exceptions.dart';
import 'package:objectid/objectid.dart';
import 'package:http/http.dart' as http;

import 'package:gymprime/core/constants/constants.dart';
import 'package:gymprime/core/utils/headers.dart';
import 'package:gymprime/features/shared/data/models/recipe_model.dart';

abstract class RecipeRemoteDataSource {
  Future<List<RecipeModel>> getAllRecipes();
  Future<(List<RecipeModel>, int)> getMyRecipes();
  Future<RecipeModel> getRecipe(ObjectId id);
  Future<(ObjectId, int)> createRecipe(RecipeModel recipe);
  Future<int> updateRecipe(RecipeModel recipe);
  Future<int> deleteRecipe(ObjectId id);
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  final http.Client client;
  final String routeName;

  RecipeRemoteDataSourceImpl({
    required this.client,
    required this.routeName,
  });

  @override
  Future<List<RecipeModel>> getAllRecipes() async {
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
      final List<Map<String, dynamic>> recipesJson = json['recipes'];
      final List<RecipeModel> recipes = [];
      for (Map<String, dynamic> recipeJson in recipesJson) {
        recipes.add(RecipeModel.fromJson(recipeJson));
      }
      return recipes;
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<(List<RecipeModel>, int)> getMyRecipes() async {
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
      final List<Map<String, dynamic>> recipesJson = json['recipes'];
      final List<RecipeModel> recipes = [];
      for (Map<String, dynamic> recipeJson in recipesJson) {
        recipes.add(RecipeModel.fromJson(recipeJson));
      }
      final int recipesLastUpdate = json['recipesLastUpdate'];
      return (recipes, recipesLastUpdate);
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<RecipeModel> getRecipe(ObjectId id) async {
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
      final Map<String, dynamic> recipeJson = json['recipe'];
      final RecipeModel recipe = RecipeModel.fromJson(recipeJson);
      return recipe;
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<(ObjectId, int)> createRecipe(RecipeModel recipe) async {
    final response = await client.post(
      Uri.http(
        APIBaseURL,
        routeName,
      ),
      headers: generateHeaders(
        contentType: ContentType.json,
        authorization: true,
      ),
      body: jsonEncode(recipe),
    );
    if (response.statusCode == 201) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final ObjectId recipeId = ObjectId.fromHexString(json['recipeId']);
      final int recipesLastUpdate = json['recipesLastUpdate'];
      return (recipeId, recipesLastUpdate);
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<int> updateRecipe(RecipeModel recipe) async {
    final response = await client.put(
      Uri.http(
        APIBaseURL,
        '$routeName/${recipe.id.toString()}',
      ),
      headers: generateHeaders(
        contentType: ContentType.json,
        authorization: true,
      ),
      body: jsonEncode(recipe),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final int recipesLastUpdate = json['recipesLastUpdate'];
      return recipesLastUpdate;
    } else {
      throw ServerException(response: response);
    }
  }

  @override
  Future<int> deleteRecipe(ObjectId id) async {
    final response = await client.delete(
      Uri.http(
        APIBaseURL,
        '$routeName/${id.toString()}',
      ),
      headers: generateHeaders(contentType: null, authorization: true),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final int recipesLastUpdate = json['recipesLastUpdate'];
      return recipesLastUpdate;
    } else {
      throw ServerException(response: response);
    }
  }
}
