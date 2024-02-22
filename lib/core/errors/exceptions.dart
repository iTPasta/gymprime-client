import 'package:http/http.dart' as http;

class ServerException implements Exception {
  final http.Response response;

  ServerException({
    required this.response,
  });
}

class CacheException implements Exception {}
