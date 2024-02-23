import 'dart:convert';

import 'package:gymprime/features/shared/domain/entities/recipe_entity.dart';
import 'package:objectid/objectid.dart';

class RecipeModel extends RecipeEntity {
  const RecipeModel({
    required super.id,
    super.name,
    super.description,
    required super.ingredients,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> map) {
    return RecipeModel(
      id: map['_id'] != null
          ? ObjectId.fromHexString(map['_id'])
          : ObjectId.fromHexString(map['id']),
      name: map['name'],
      description: map['description'],
      ingredients: map['ingredients'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': jsonEncode(id),
      'name': jsonEncode(name),
      'description': jsonEncode(description),
      'ingredients': jsonEncode(ingredients),
    };
  }

  RecipeEntity toEntity() {
    return RecipeModel(
      id: id,
      name: name,
      description: description,
      ingredients: ingredients,
    );
  }

  static List<RecipeModel> fromJsonToList(
    List<Map<String, dynamic>> jsonRecipes,
  ) {
    final List<RecipeModel> recipesList = [];
    for (final jsonRecipe in jsonRecipes) {
      recipesList.add(RecipeModel.fromJson(jsonRecipe));
    }
    return recipesList;
  }
}
