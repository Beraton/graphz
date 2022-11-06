import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:graphz/core/usecases/usecase.dart';
import 'package:graphz/features/weather/domain/repositories/weather_repository.dart';

import '../../../../core/errors/failure.dart';
import '../entities/weather_list.dart';

class GetSelectedDayWeather implements UseCase<WeatherList, Params> {
  final WeatherRepository repository;

  GetSelectedDayWeather(this.repository);

  @override
  Future<Either<Failure, WeatherList>> call(Params params) async {
    return await repository.getSelectedDayWeather(params.selectedDay);
  }
}

class Params extends Equatable {
  final DateTime selectedDay;

  Params({required this.selectedDay});

  @override
  List<Object?> get props => [selectedDay];
}
