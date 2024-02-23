import "package:http/http.dart" as http;

enum HttpMethod {
  get,
  post,
  put,
  patch,
  delete,
}

extension HttpMethodExtension on HttpMethod {
  String toJson() {
    return name;
  }

  static HttpMethod? fromString(String str) {
    for (HttpMethod method in HttpMethod.values) {
      if (method.name == str) {
        return method;
      }
    }
    return null;
  }

  Function getFunction() {
    switch (this) {
      case HttpMethod.get:
        return http.get;
      case HttpMethod.post:
        return http.post;
      case HttpMethod.put:
        return http.put;
      case HttpMethod.patch:
        return http.patch;
      case HttpMethod.delete:
        return http.delete;
    }
  }
}
