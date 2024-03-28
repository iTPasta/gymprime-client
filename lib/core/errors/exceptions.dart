import 'package:gymprime/core/enums/model_type.dart';
import 'package:http/http.dart' as http;
import 'package:objectid/objectid.dart';

class ServerException implements Exception {
  final http.Response response;

  ServerException({
    required this.response,
  });
}

class CacheException implements Exception {}

class NoRowAffectedException extends CacheException {}

class MultipleRowsAffectedException extends CacheException {}

class NoRowInsertedException extends CacheException {}

class CacheInconsistencyException extends CacheException {
  CacheInconsistencyException({
    required List<Object?> cache,
    required Object? cachedObject,
  });
}

class UnknownIdException extends CacheException {
  UnknownIdException({
    required ModelType modelType,
    required ObjectId id,
  });
}
