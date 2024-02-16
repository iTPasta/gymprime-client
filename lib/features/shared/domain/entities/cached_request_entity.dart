// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:gymprime/core/resources/request_type.dart';
import 'package:gymprime/features/shared/data/models/cache_request_model.dart';
import 'package:objectid/objectid.dart';

class CachedRequestEntity {
  final ObjectId id;
  final RequestType requestType;
  final Map<String, dynamic> headers;
  final Map<String, dynamic> body;
  final int date;

  const CachedRequestEntity({
    required this.id,
    required this.requestType,
    required this.headers,
    required this.body,
    required this.date,
  });

  List<Object> get props {
    return [
      requestType,
      headers,
      body,
      date,
    ];
  }

  CachedRequestModel toModel() {
    return CachedRequestModel(
      id: id,
      requestType: requestType,
      headers: headers,
      body: body,
      date: date,
    );
  }
}
