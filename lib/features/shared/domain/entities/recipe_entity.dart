// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:gymprime/features/shared/data/models/recipe_model.dart';
import 'package:objectid/objectid.dart';

class RecipeEntity {
  final ObjectId id;
  final String? name;
  final String? description;
  final Map<String, dynamic> ingredients;

  const RecipeEntity({
    required this.id,
    this.name,
    this.description,
    required this.ingredients,
  });

  List<Object?> get props => [
        id,
        name,
        description,
        ingredients,
      ];

  RecipeModel toModel() {
    return RecipeModel(
      id: id,
      name: name,
      description: description,
      ingredients: ingredients,
    );
  }
}
