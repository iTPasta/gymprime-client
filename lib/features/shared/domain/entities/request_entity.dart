// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:gymprime/core/enums/http_method.dart';
import 'package:gymprime/features/shared/data/models/request_model.dart';
import 'package:objectid/objectid.dart';

class RequestEntity {
  final ObjectId id;
  final HttpMethod httpMethod;
  final Uri uri;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? body;
  final int date;

  const RequestEntity({
    required this.id,
    required this.date,
    required this.httpMethod,
    required this.uri,
    this.headers,
    this.body,
  });

  List<Object?> get props {
    return [
      httpMethod,
      uri,
      headers,
      body,
      date,
    ];
  }

  RequestModel toModel() {
    return RequestModel(
      id: id,
      httpMethod: httpMethod,
      uri: uri,
      headers: headers,
      body: body,
      date: date,
    );
  }
}
