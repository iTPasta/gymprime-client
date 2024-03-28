enum ActionType { create, update, delete }

extension ActionTypeExtension on ActionType {
  String toJson() {
    return toString();
  }

  static ActionType? fromJson(String json) {
    for (ActionType action in ActionType.values) {
      if (action.toString() == json) {
        return action;
      }
    }
    return null;
  }
}
