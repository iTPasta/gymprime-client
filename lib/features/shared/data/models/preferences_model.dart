import 'dart:convert';

import 'package:gymprime/features/shared/domain/entities/preferences_entity.dart';

class PreferencesModel extends PreferencesEntity {
  const PreferencesModel({
    required super.theme,
  });

  factory PreferencesModel.fromJson(Map<String, dynamic> map) {
    return PreferencesModel(
      theme: map['theme'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'theme': jsonEncode(theme),
    };
  }

  PreferencesEntity toEntity() {
    return PreferencesEntity(
      theme: theme,
    );
  }
}
