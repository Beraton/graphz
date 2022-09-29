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

double getMaxValue(WeatherList weather, ParamType type) {
  double max = 0;
  switch (type) {
    case ParamType.temperature:
      for (var element in weather.weatherList) {
        if (element.tempRaw > max) max = element.tempRaw;
      }
      max = max + 1.0;
      break;
    case ParamType.humidity:
      for (var element in weather.weatherList) {
        if (element.humRaw > max) max = element.humRaw;
      }
      max = max + 1.0;
      break;
    case ParamType.pressure:
      for (var element in weather.weatherList) {
        if (element.presRaw > max) max = element.presRaw;
      }
      max = max + 5.0;
      break;
    case ParamType.light:
      for (var element in weather.weatherList) {
        if (element.lux > max) max = element.lux.toDouble();
      }
      max = max + 5.0;
      break;
  }
  return max;
}

double getMinValue(WeatherList weather, ParamType type) {
  double min = 10000;
  switch (type) {
    case ParamType.temperature:
      for (var element in weather.weatherList) {
        if (element.tempRaw < min) min = element.tempRaw;
      }
      min = min - 1.0;
      break;
    case ParamType.humidity:
      for (var element in weather.weatherList) {
        if (element.humRaw < min) min = element.humRaw;
      }
      min = min - 1.0;
      break;
    case ParamType.pressure:
      for (var element in weather.weatherList) {
        if (element.presRaw < min) min = element.presRaw;
      }
      min = min - 5.0;
      break;
    case ParamType.light:
      for (var element in weather.weatherList) {
        if (element.lux < min) min = element.lux.toDouble();
      }
      min = min - 5.0;
      break;
  }
  return min;
}

double parseChartSpotData(num value, num mod) {
  return (((value * mod).round().toDouble() / mod));
}

List<FlSpot> generateChartSpots(WeatherList data, ParamType type) {
  List<FlSpot> result = [];
  double i = 0;
  //TODO: change 1 to CONFIG_FLOATING_POINT_PRECISION variable
  num prec = pow(10.0, 1);

  switch (type) {
    case ParamType.temperature:
      for (int x = 0; x < data.weatherList.length; x++) {
        result.add(
          FlSpot(
            i++,
            parseChartSpotData(data.weatherList[x].tempRaw, prec),
          ),
        );
      }
      break;
    case ParamType.humidity:
      for (int x = 0; x < data.weatherList.length; x++) {
        result.add(
          FlSpot(
            i++,
            parseChartSpotData(data.weatherList[x].humRaw, prec),
          ),
        );
      }
      break;
    case ParamType.pressure:
      for (int x = 0; x < data.weatherList.length; x++) {
        result.add(
          FlSpot(
            i++,
            parseChartSpotData(data.weatherList[x].presRaw, prec),
          ),
        );
      }
      break;
    case ParamType.light:
      for (int x = 0; x < data.weatherList.length; x++) {
        result.add(
          FlSpot(
            i++,
            parseChartSpotData(data.weatherList[x].lux, prec),
          ),
        );
      }
      break;
  }
  return result;
}
