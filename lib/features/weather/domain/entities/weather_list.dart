import 'package:equatable/equatable.dart';
import 'package:graphz/features/weather/domain/entities/weather.dart';

enum ParamType {
  temperature,
  humidity,
  pressure,
  light,
}

class WeatherList extends Equatable {
  final List<Weather> weatherList;

  WeatherList(this.weatherList);

  List<double> extractWeatherValue(ParamType type) {
    List<double> res = [];
    Map<ParamType, Function> map = {
      ParamType.temperature: () => weatherList.forEach((i) {
            res.add(i.temperature);
          }),
      ParamType.humidity: () => weatherList.forEach((i) {
            res.add(i.humidity);
          }),
      ParamType.pressure: () => weatherList.forEach((i) {
            res.add(i.pressure);
          }),
      ParamType.light: () => weatherList.forEach((i) {
            res.add(i.light);
          }),
    };
    map[type]!.call();
    return res;
  }

  Weather get getCurrent => weatherList.last;

  @override
  List<Object?> get props => [weatherList];
}
