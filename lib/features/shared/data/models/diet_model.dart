import 'dart:convert';

import 'package:gymprime/features/shared/domain/entities/diet_entity.dart';

class DietModel extends DietEntity {
  const DietModel({
    required super.id,
    super.name,
    super.description,
    required super.meals,
  });

  factory DietModel.fromJson(Map<String, dynamic> map) {
    return DietModel(
      id: map['_id'] ?? map['id'],
      name: map['name'],
      description: map['description'],
      meals: map['meals'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': jsonEncode(id),
      'name': jsonEncode(name),
      'description': jsonEncode(description),
      'meals': jsonEncode(meals),
    };
  }

  DietEntity toEntity() {
    return DietEntity(
      id: id,
      name: name,
      description: description,
      meals: meals,
    );
  }
}
