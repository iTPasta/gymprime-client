enum RequestType {
  getAllData,
  getPublicData,
  getMyData,
  getAllAliments,
}

extension RequestTypeExtension on RequestType {
  String toJson() {
    return name;
  }
}
