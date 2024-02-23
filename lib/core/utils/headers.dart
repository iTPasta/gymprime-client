import 'package:gymprime/core/di/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferences = sl<SharedPreferences>();

enum ContentType { json }

extension ContentTypeExtension on ContentType {
  String toHeaderString() {
    switch (this) {
      case ContentType.json:
        return 'application/json';
    }
  }
}

Map<String, String> generateHeaders({
  required ContentType? contentType,
  required bool authorization,
}) {
  final Map<String, String> header = {};

  if (contentType != null) {
    header['Content-Type'] = contentType.toHeaderString();
  }

  if (authorization) {
    header['Authorization'] = 'Bearer ${sharedPreferences.getString("token")}';
  }

  return header;
}
