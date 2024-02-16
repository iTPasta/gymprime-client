import 'package:objectid/objectid.dart';

extension ObjectIdExtension on ObjectId {
  String toJson() {
    return toString();
  }
}
