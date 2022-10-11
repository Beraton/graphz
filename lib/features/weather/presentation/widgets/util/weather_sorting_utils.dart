import 'dart:ffi';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:graphz/features/weather/domain/entities/weather.dart';

import '../../../domain/entities/weather_list.dart';

enum ParamType {
  temperature,
  humidity,
  pressure,
  light,
}

List<double> getParameterFromWeather(WeatherList weather, ParamType? type) {
  List<double> res = [];
  switch (type) {
    case ParamType.temperature:
      for (var e in weather.weatherList) {
        res.add(e.temperature);
      }
      break;
    case ParamType.humidity:
      for (var e in weather.weatherList) {
        res.add(e.humidity);
      }
      break;
    case ParamType.pressure:
      for (var e in weather.weatherList) {
        res.add(e.pressure);
      }
      break;
    case ParamType.light:
      for (var e in weather.weatherList) {
        res.add(e.light);
      }
      break;
    case null:
      break;
  }
  return res;
}

double getMaxValue(WeatherList weather, ParamType type) {
  num max = 0;
  switch (type) {
    case ParamType.temperature:
      for (var element in weather.weatherList) {
        if (element.tempRaw > max) max = element.tempRaw;
      }
      max = max + 1.0;
      break;
    case ParamType.humidity:
      for (var element in weather.weatherList) {
        if (element.humidity > max) max = element.humidity;
      }
      max = max + 1.0;
      break;
    case ParamType.pressure:
      for (var element in weather.weatherList) {
        if (element.pressure > max) max = element.pressure;
      }
      max = max + 5.0;
      break;
    case ParamType.light:
      for (var element in weather.weatherList) {
        if (element.light > max) max = element.light.toDouble();
      }
      max = max + 5.0;
      break;
  }
  return max.toDouble();
}

double getMinValue(WeatherList weather, ParamType type) {
  num min = 10000;
  switch (type) {
    case ParamType.temperature:
      for (var element in weather.weatherList) {
        if (element.temperature < min) min = element.temperature;
      }
      min = min - 1.0;
      break;
    case ParamType.humidity:
      for (var element in weather.weatherList) {
        if (element.humidity < min) min = element.humidity;
      }
      min = min - 1.0;
      break;
    case ParamType.pressure:
      for (var element in weather.weatherList) {
        if (element.pressure < min) min = element.pressure;
      }
      min = min - 5.0;
      break;
    case ParamType.light:
      for (var element in weather.weatherList) {
        if (element.light < min) min = element.light.toDouble();
      }
      min = min - 5.0;
      break;
  }
  return min.toDouble();
}

List<FlSpot> generateChartSpots(WeatherList data, ParamType type) {
  List<FlSpot> result = [];
  double i = 0;

  switch (type) {
    case ParamType.temperature:
      for (int x = 0; x < data.weatherList.length; x++) {
        result.add(
          FlSpot(
            i++,
            data.weatherList[x].temperature,
          ),
        );
      }
      break;
    case ParamType.humidity:
      for (int x = 0; x < data.weatherList.length; x++) {
        result.add(
          FlSpot(
            i++,
            data.weatherList[x].humidity,
          ),
        );
      }
      break;
    case ParamType.pressure:
      for (int x = 0; x < data.weatherList.length; x++) {
        result.add(
          FlSpot(
            i++,
            data.weatherList[x].pressure,
          ),
        );
      }
      break;
    case ParamType.light:
      for (int x = 0; x < data.weatherList.length; x++) {
        result.add(
          FlSpot(
            i++,
            data.weatherList[x].light,
          ),
        );
      }
      break;
  }
  return result;
}
