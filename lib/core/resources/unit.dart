enum Unit {
  kg,
  g,
  mg,
}

extension UnitExtension on Unit {
  String toJson() {
    return name;
  }
}
