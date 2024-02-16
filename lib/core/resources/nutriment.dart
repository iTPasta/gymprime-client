enum Nutriment {
  proteins,
}

extension NutrimentExtension on Nutriment {
  String toJson() {
    return name;
  }
}
