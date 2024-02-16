import 'dart:convert';

import 'package:gymprime/features/shared/domain/entities/meal_entity.dart';

class MealModel extends MealEntity {
  const MealModel({
    required super.id,
    super.name,
    super.description,
    required super.aliments,
    required super.recipes,
  });

  factory MealModel.fromJson(Map<String, dynamic> map) {
    return MealModel(
      id: map['_id'] ?? map['id'],
      name: map['name'],
      description: map['description'],
      aliments: map['aliments'] ?? [],
      recipes: map['recipes'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': jsonEncode(id),
      'name': jsonEncode(name),
      'description': jsonEncode(description),
      'aliments': jsonEncode(aliments),
      'recipes': jsonEncode(recipes),
    };
  }

  MealEntity toEntity() {
    return MealEntity(
      id: id,
      name: name,
      description: description,
      aliments: aliments,
      recipes: recipes,
    );
  }
}
