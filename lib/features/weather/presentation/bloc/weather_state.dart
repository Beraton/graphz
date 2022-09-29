part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class Initial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherList weather;

  WeatherLoaded({required this.weather});

  @override
  List<Object> get props => [weather];
}

class Error extends WeatherState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
