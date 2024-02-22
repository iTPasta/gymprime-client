import 'package:gymprime/features/shared/data/models/preferences_model.dart';

class PreferencesEntity {
  final String theme;

  const PreferencesEntity({
    required this.theme,
  });

  List<Object> get props {
    return [theme];
  }

  PreferencesModel toModel() {
    return PreferencesModel(
      theme: theme,
    );
  }
}
