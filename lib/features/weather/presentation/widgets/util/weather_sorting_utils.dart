import 'package:fl_chart/fl_chart.dart';

import '../../../domain/entities/weather.dart';
import '../../../domain/entities/weather_list.dart';

String createCurrentValue(String cardTitle, WeatherList weatherList) {
  Map<String, String> map = {
    "Temperature": "${weatherList.getCurrent.temperature.toString()} °C",
    "Humidity": "${weatherList.getCurrent.humidity.toString()} %",
    "Pressure": "${weatherList.getCurrent.pressure.toString()} hPa",
    "Light": "${weatherList.getCurrent.light.toString()} lux",
  };
  return map[cardTitle]!;
}

String mapParamTypeToTitle(ParamType paramType) {
  const Map<ParamType, String> map = {
    ParamType.temperature: "Temperature",
    ParamType.humidity: "Humidity",
    ParamType.pressure: "Pressure",
    ParamType.light: "Light",
  };
  return map[paramType]!;
}

List<double> getParameterFromWeather(WeatherList weather, ParamType type) {
  return weather.extractWeatherValue(type);
}

double getMaxValue(WeatherList weather, ParamType type) {
  num max = 0;
  for (var e in weather.extractWeatherValue(type)) {
    if (e > max) max = e;
  }
  return max.toDouble() + 1.0;
}

double getMinValue(WeatherList weather, ParamType type) {
  num min = 10000;
  for (var e in weather.extractWeatherValue(type)) {
    if (e < min) min = e;
  }
  return min.toDouble() - 1.0;
}

List<FlSpot> generateChartSpots(WeatherList data, ParamType type) {
  List<FlSpot> result = [];
  double i = 0;

  for (var e in data.extractWeatherValue(type)) {
    result.add(FlSpot(i++, e));
  }

  return result;
}
