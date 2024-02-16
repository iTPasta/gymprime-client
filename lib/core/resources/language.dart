enum Language {
  en,
  fr,
}

extension LanguageExtension on Language {
  String toJson() {
    return name;
  }
}
