import 'package:dartz/dartz.dart';
import 'package:graphz/features/weather/domain/entities/weather_list.dart';

import '../../../../core/errors/failure.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherList>> getWeeklyWeather();
  Future<Either<Failure, WeatherList>> getFullYearWeather();
  Future<Either<Failure, WeatherList>> getSelectedDayWeather(
      DateTime selectedDay);
}
