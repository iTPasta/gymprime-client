// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:gymprime/core/resources/language.dart';
import 'package:gymprime/features/shared/data/models/muscle_model.dart';
import 'package:objectid/objectid.dart';

class MuscleEntity {
  final ObjectId id;
  final Map<Language, String> names;
  final Map<Language, String> descriptions;
  final List<ObjectId> exercises;
  final ObjectId? muscleGroup;

  const MuscleEntity({
    required this.id,
    required this.names,
    required this.descriptions,
    required this.exercises,
    this.muscleGroup,
  });

  List<Object?> get props => [
        id,
        names,
        descriptions,
        exercises,
        muscleGroup,
      ];

  MuscleModel toModel() {
    return MuscleModel(
      id: id,
      names: names,
      descriptions: descriptions,
      exercises: exercises,
      muscleGroup: muscleGroup,
    );
  }
}
