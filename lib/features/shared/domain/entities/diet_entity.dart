// ignore_for_fileic_member_api_docs, sort_constructors_first
import 'package:gymprime/features/shared/data/models/diet_model.dart';
import 'package:objectid/objectid.dart';

class DietEntity {
  final ObjectId id;
  final String? name;
  final String? description;
  final List<ObjectId> meals;

  const DietEntity({
    required this.id,
    this.name,
    this.description,
    required this.meals,
  });

  List<Object?> get props => [
        id,
        name,
        description,
        meals,
      ];

  DietModel toModel() {
    return DietModel(
      id: id,
      name: name,
      description: description,
      meals: meals,
    );
  }
}

extension DietEntityList on List<DietEntity> {
  List<DietModel> toModelList() {
    final List<DietModel> dietModels = [];
    for (DietEntity dietEntity in this) {
      dietModels.add(dietEntity.toModel());
    }
    return dietModels;
  }
}
