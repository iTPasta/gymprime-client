import 'package:gymprime/core/errors/exceptions.dart';
import 'package:gymprime/core/resources/data_state.dart';
import 'package:gymprime/features/shared/data/datasources/local/action_local_database.dart';
import 'package:gymprime/features/shared/data/models/action_model.dart';
import 'package:gymprime/features/shared/domain/entities/action_entity.dart';
import 'package:gymprime/features/shared/domain/repositories/action_repository.dart';
import 'package:objectid/objectid.dart';

class CachedActionRepositoryImpl implements CachedActionRepository {
  final CachedActionLocalDataSource cachedActionDataSource;

  CachedActionRepositoryImpl({
    required this.cachedActionDataSource,
  });

  @override
  Future<DataState<List<ActionModel>>> getCachedActions() async {
    try {
      return DataSuccess(await cachedActionDataSource.getCachedActions());
    } on CacheException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<void>> cachedAction(
    ActionEntity action,
  ) async {
    try {
      return DataSuccess(
        await cachedActionDataSource.cacheAction(action.toModel()),
      );
    } on CacheException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<void>> removeCachedAction(ObjectId id) async {
    try {
      return DataSuccess(await cachedActionDataSource.removeCachedAction(id));
    } on CacheException catch (exception) {
      return DataFailure(exception);
    }
  }

  @override
  Future<DataState<void>> sendAction(ActionEntity action) {
    throw UnimplementedError();
  }
}
