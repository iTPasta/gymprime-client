import 'package:gymprime/core/resources/language.dart';
import 'package:gymprime/features/shared/data/models/exercise_model.dart';
import 'package:objectid/objectid.dart';

class ExerciseEntity {
  final ObjectId id;
  final Map<Language, String> names;
  final Map<Language, String> descriptions;
  final List<ObjectId> muscles;
  final ObjectId? muscleGroup;

  const ExerciseEntity({
    required this.id,
    required this.names,
    required this.descriptions,
    required this.muscles,
    this.muscleGroup,
  });

  List<Object?> get props => [
        id,
        names,
        descriptions,
        muscles,
        muscleGroup,
      ];

  ExerciseModel toModel() {
    return ExerciseModel(
      id: id,
      names: names,
      descriptions: descriptions,
      muscles: muscles,
      muscleGroup: muscleGroup,
    );
  }
}
