import 'package:equatable/equatable.dart';
import 'package:graphz/features/weather/domain/entities/weather.dart';

class WeatherList extends Equatable {
  final List<Weather> weatherList;

  WeatherList(this.weatherList);

  @override
  List<Object?> get props => [weatherList];
}
