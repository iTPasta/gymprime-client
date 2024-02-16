import 'package:gymprime/core/resources/data_state.dart';

abstract class UseCase<Type, Params> {
  Future<DataState<Type>> call(Params params);
}
