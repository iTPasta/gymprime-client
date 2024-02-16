import 'dart:convert';

import 'package:gymprime/features/shared/domain/entities/aliment_entity.dart';

class AlimentModel extends AlimentEntity {
  const AlimentModel({
    required super.id,
    required super.barCode,
    required super.name,
    super.ciqualCode,
    super.allergens,
    super.brands,
    super.countryCode,
    super.ecoscoreGrade,
    super.ecoscoreScore,
    super.imageUrl,
    required super.nutriments,
    super.nutriscoreGrade,
    super.nutriscoreScore,
  });

  factory AlimentModel.fromJson(Map<String, dynamic> map) {
    return AlimentModel(
      id: map['_id'] ?? map['id'],
      barCode: map['barCode'],
      name: map['name'],
      ciqualCode: map['ciqualCode'],
      allergens: map['allergens'],
      brands: map['brands'],
      countryCode: map['countryCode'],
      ecoscoreGrade: map['ecoscoreGrade'],
      ecoscoreScore: map['ecoscoreScore'],
      imageUrl: map['image_url'],
      nutriments: map['nutriments'] ?? {},
      nutriscoreGrade: map['nutriscoreGrade'],
      nutriscoreScore: map['nutriscoreScore'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': jsonEncode(id),
      'barCode': jsonEncode(barCode),
      'name': jsonEncode(name),
      'ciqualCode': jsonEncode(ciqualCode),
      'allergens': jsonEncode(allergens),
      'brands': jsonEncode(brands),
      'countryCode': jsonEncode(countryCode),
      'ecoscoreGrade': jsonEncode(ecoscoreGrade),
      'ecoscoreScore': jsonEncode(ecoscoreScore),
      'imageUrl': jsonEncode(imageUrl),
      'nutriments': jsonEncode(nutriments),
      'nutriscoreGrade': jsonEncode(nutriscoreGrade),
      'nutriscoreScore': jsonEncode(nutriscoreScore),
    };
  }

  AlimentEntity toEntity() {
    return AlimentEntity(
      id: id,
      barCode: barCode,
      name: name,
      ciqualCode: ciqualCode,
      allergens: allergens,
      brands: brands,
      countryCode: countryCode,
      ecoscoreGrade: ecoscoreGrade,
      ecoscoreScore: ecoscoreScore,
      imageUrl: imageUrl,
      nutriments: nutriments,
      nutriscoreGrade: nutriscoreGrade,
      nutriscoreScore: nutriscoreScore,
    );
  }
}
