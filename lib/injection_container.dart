import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get_it/get_it.dart';
import 'package:graphz/core/network/network_info.dart';
import 'package:graphz/core/presentation/bloc/navigation_bloc.dart';
import 'package:graphz/features/weather/data/datasources/weather_local_datasource.dart';
import 'package:graphz/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:graphz/features/weather/domain/repositories/weather_repository.dart';
import 'package:graphz/features/weather/domain/usecases/get_full_year_weather.dart';
import 'package:graphz/features/weather/domain/usecases/get_weekly_weather.dart';
import 'package:graphz/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;

import 'features/weather/data/datasources/weather_remote_datasource.dart';

final sl = GetIt.instance;

void init() {
  /* Features - Weather */

  // Bloc
  sl.registerFactory(
    () => WeatherBloc(
      fullYear: sl(),
      weeklyWeather: sl(),
    ),
  );
  sl.registerFactory(() => NavigationBloc());

  // Use cases
  sl.registerLazySingleton(() => GetFullYearWeather(sl()));
  sl.registerLazySingleton(() => GetWeeklyWeather(sl()));

  // Repository
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      remoteDatasource: sl(),
      localDatasource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<WeatherLocalDatasource>(
      () => WeatherLocalDatasourceImpl(hiveInterface: sl()));
  sl.registerLazySingleton<WeatherRemoteDatasource>(
      () => WeatherRemoteDatasourceImpl(client: sl()));

  /* Core */
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /* External */
  // Hive is a variable name to access the HiveImpl() class instance, maybe it will work
  sl.registerLazySingleton(() => Hive);
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => http.Client());
}
