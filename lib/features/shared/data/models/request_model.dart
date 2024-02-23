import 'dart:convert';

import 'package:gymprime/core/enums/http_method.dart';
import 'package:gymprime/features/shared/domain/entities/request_entity.dart';
import 'package:objectid/objectid.dart';

class RequestModel extends RequestEntity {
  const RequestModel({
    required super.id,
    required super.date,
    required super.httpMethod,
    required super.uri,
    required super.headers,
    required super.body,
  });

  factory RequestModel.fromJson(Map<String, dynamic> map) {
    return RequestModel(
      id: jsonDecode(map['_id']) != null
          ? ObjectId.fromHexString(map['_id'])
          : ObjectId.fromHexString(map['id']),
      date: jsonDecode(map['date']),
      httpMethod: HttpMethodExtension.fromString(map['httpMethod'])!,
      uri: Uri.dataFromString(map['uri']),
      headers: jsonDecode(map['headers']),
      body: jsonDecode(map['body']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': jsonEncode(id),
      'httpMethod': jsonEncode(httpMethod),
      'headers': jsonEncode(headers),
      'body': jsonEncode(body),
      'date': jsonEncode(date),
    };
  }

  RequestEntity toEntity() {
    return RequestEntity(
      id: id,
      httpMethod: httpMethod,
      uri: uri,
      headers: headers,
      body: body,
      date: date,
    );
  }

  static List<RequestModel> fromJsonToList(
    List<Map<String, dynamic>> jsonCachedRequests,
  ) {
    final List<RequestModel> cachedRequestsList = [];
    for (final jsonCachedRequest in jsonCachedRequests) {
      cachedRequestsList.add(RequestModel.fromJson(jsonCachedRequest));
    }
    return cachedRequestsList;
  }
}
