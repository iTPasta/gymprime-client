// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:gymprime/features/shared/data/models/training_model.dart';
import 'package:objectid/objectid.dart';

class TrainingEntity {
  final ObjectId id;
  final String? name;
  final String? notes;
  final List<Map<String, Object>> sets;

  const TrainingEntity({
    required this.id,
    this.name,
    this.notes,
    required this.sets,
  });

  List<Object?> get props => [
        id,
        name,
        notes,
        sets,
      ];

  TrainingModel toModel() {
    return TrainingModel(
      id: id,
      name: name,
      notes: notes,
      sets: sets,
    );
  }
}
