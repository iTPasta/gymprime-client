// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:gymprime/core/resources/nutriment.dart';
import 'package:gymprime/features/shared/data/models/aliment_model.dart';
import 'package:objectid/objectid.dart';

class AlimentEntity {
  final ObjectId id;
  final String barCode;
  final String name;
  final int? ciqualCode;
  final String? allergens;
  final String? brands;
  final String? countryCode;
  final String? ecoscoreGrade;
  final int? ecoscoreScore;
  final String? imageUrl;
  final Map<Nutriment, double> nutriments;
  final String? nutriscoreGrade;
  final int? nutriscoreScore;

  const AlimentEntity({
    required this.id,
    required this.barCode,
    required this.name,
    this.ciqualCode,
    this.allergens,
    this.brands,
    this.countryCode,
    this.ecoscoreGrade,
    this.ecoscoreScore,
    this.imageUrl,
    required this.nutriments,
    this.nutriscoreGrade,
    this.nutriscoreScore,
  });

  List<Object> get props {
    return [
      id,
      barCode,
      name,
    ];
  }

  AlimentModel toModel() {
    return AlimentModel(
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
