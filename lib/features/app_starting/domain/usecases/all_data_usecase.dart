import 'package:gymprime/core/errors/failures.dart';
import 'package:gymprime/features/app_starting/domain/repository/all_data_repo.dart';

class FetchAllData {
  final AllDataRepository repo;

  Future<Either<Failure, Map<Type, List<dynamic>>>> execute() =>
      repo.fetchAllData();
}
