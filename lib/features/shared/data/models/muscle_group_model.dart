import 'dart:convert';

import 'package:gymprime/features/shared/domain/entities/muscle_group_entity.dart';

class MuscleGroupModel extends MuscleGroupEntity {
  const MuscleGroupModel({
    required super.id,
    required super.names,
    required super.descriptions,
    required super.muscles,
  });

  factory MuscleGroupModel.fromJson(Map<String, dynamic> map) {
    return MuscleGroupModel(
      id: map['_id'] ?? map['id'],
      names: map['names'] ?? {},
      descriptions: map['descriptions'] ?? {},
      muscles: map['muscles'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': jsonEncode(id),
      'names': jsonEncode(names),
      'descriptions': jsonEncode(descriptions),
      'muscles': jsonEncode(muscles),
    };
  }

  MuscleGroupEntity toEntity() {
    return MuscleGroupEntity(
      id: id,
      names: names,
      descriptions: descriptions,
      muscles: muscles,
    );
  }
}
