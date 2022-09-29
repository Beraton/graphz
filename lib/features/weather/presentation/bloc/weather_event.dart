part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class GetFullYearWeatherEvent extends WeatherEvent {}

class GetLastWeekWeatherEvent extends WeatherEvent {}
