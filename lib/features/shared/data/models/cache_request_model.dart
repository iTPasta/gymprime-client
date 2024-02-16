import 'dart:convert';

import 'package:gymprime/features/shared/domain/entities/cached_request_entity.dart';

class CachedRequestModel extends CachedRequestEntity {
  const CachedRequestModel({
    required super.id,
    required super.requestType,
    required super.headers,
    required super.body,
    required super.date,
  });

  factory CachedRequestModel.fromJson(Map<String, dynamic> map) {
    return CachedRequestModel(
      id: map['_id'] ?? map['id'],
      requestType: map['actionType'],
      headers: map['headers'] ?? {},
      body: map['body'] ?? {},
      date: map['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': jsonEncode(id),
      'actionType': jsonEncode(requestType),
      'headers': jsonEncode(headers),
      'body': jsonEncode(body),
      'date': jsonEncode(date),
    };
  }

  CachedRequestEntity toEntity() {
    return CachedRequestEntity(
      id: id,
      requestType: requestType,
      headers: headers,
      body: body,
      date: date,
    );
  }
}
