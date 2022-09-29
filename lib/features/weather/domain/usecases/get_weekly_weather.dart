import 'package:dartz/dartz.dart';
import 'package:graphz/features/weather/domain/entities/weather_list.dart';
import 'package:graphz/features/weather/domain/repositories/weather_repository.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';

class GetWeeklyWeather implements UseCase<WeatherList, NoParams> {
  final WeatherRepository repository;

  GetWeeklyWeather(this.repository);

  @override
  Future<Either<Failure, WeatherList>> call(NoParams params) async {
    return await repository.getWeeklyWeather();
  }
}
