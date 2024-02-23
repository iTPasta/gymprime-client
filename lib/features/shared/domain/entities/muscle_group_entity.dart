// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:gymprime/core/enums/language.dart';
import 'package:gymprime/features/shared/data/models/muscle_group_model.dart';
import 'package:objectid/objectid.dart';

class MuscleGroupEntity {
  final ObjectId id;
  final Map<Language, String> names;
  final Map<Language, String> descriptions;
  final List<ObjectId> muscles;

  const MuscleGroupEntity({
    required this.id,
    required this.names,
    required this.descriptions,
    required this.muscles,
  });

  List<Object?> get props => [
        id,
        names,
        descriptions,
        muscles,
      ];

  MuscleGroupModel toModel() {
    return MuscleGroupModel(
      id: id,
      names: names,
      descriptions: descriptions,
      muscles: muscles,
    );
  }
}
