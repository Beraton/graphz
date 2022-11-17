import 'package:dartz/dartz.dart';
import 'package:graphz/core/network/network_info.dart';
import 'package:graphz/features/weather/data/datasources/weather_local_datasource.dart';
import 'package:graphz/features/weather/data/datasources/weather_remote_datasource.dart';
import 'package:graphz/features/weather/domain/repositories/weather_repository.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/weather_list.dart';
import '../models/weather_model_list.dart';

typedef _FullWeeklyOrDailyWeatherChooser = Future<WeatherModelList> Function();

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDatasource remoteDatasource;
  final WeatherLocalDatasource localDatasource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, WeatherList>> getWeeklyWeather() async {
    return await _getWeather(
      () {
        return remoteDatasource.getWeeklyWeather();
      },
    );
  }

  @override
  Future<Either<Failure, WeatherModelList>> getFullYearWeather() async {
    return await _getWeather(
      () {
        return remoteDatasource.getFullYearWeather();
      },
    );
  }

  @override
  Future<Either<Failure, WeatherModelList>> getSelectedDayWeather(
      String selectedDay) async {
    return await _getWeather(
      () {
        return remoteDatasource.getSelectedDayWeather(selectedDay);
      },
    );
  }

  Future<Either<Failure, WeatherModelList>> _getWeather(
      _FullWeeklyOrDailyWeatherChooser getFullWeeklyOrDaily) async {
    Future<bool> isConn = networkInfo.isConnected;
    if (await isConn == true) {
      try {
        final remoteWeather = await getFullWeeklyOrDaily();
        localDatasource.cacheWeeklyWeather(remoteWeather);
        return Right(remoteWeather);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localWeather = await localDatasource.getCachedWeeklyWeather();
        return Right(localWeather);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
