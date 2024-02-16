import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gymprime/features/shared/data/datasources/local/database/local_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // HTTP Client
  sl.registerSingleton<http.Client>(http.Client());

  // Local database
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  LocalDatabase().initialize();

  // Repositories
}
