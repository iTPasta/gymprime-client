// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:gymprime/features/shared/data/models/meal_model.dart';
import 'package:objectid/objectid.dart';

class MealEntity {
  final ObjectId id;
  final String? name;
  final String? description;
  final List<Map<String, dynamic>> aliments;
  final List<Map<String, dynamic>> recipes;

  const MealEntity({
    required this.id,
    this.name,
    this.description,
    required this.aliments,
    required this.recipes,
  });

  List<Object?> get props => [
        id,
        name,
        description,
        aliments,
        recipes,
      ];

  MealModel toModel() {
    return MealModel(
      id: id,
      name: name,
      description: description,
      aliments: aliments,
      recipes: recipes,
    );
  }
}
