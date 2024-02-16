// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:gymprime/features/shared/data/models/program_model.dart';
import 'package:objectid/objectid.dart';

class ProgramEntity {
  final ObjectId id;
  final String? name;
  final String? description;
  final List<ObjectId> exercises;
  final List<ObjectId> trainings;
  final List<Map<String, dynamic>> goal;

  const ProgramEntity({
    required this.id,
    this.name,
    this.description,
    required this.exercises,
    required this.trainings,
    required this.goal,
  });

  List<Object?> get props {
    return [
      id,
      name,
      description,
      exercises,
      trainings,
      goal,
    ];
  }

  ProgramModel toModel() {
    return ProgramModel(
      id: id,
      name: name,
      description: description,
      exercises: exercises,
      trainings: trainings,
      goal: goal,
    );
  }
}
