import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphz/features/weather/data/models/weather_model.dart';
import 'package:graphz/features/weather/data/models/weather_model_list.dart';
import 'package:graphz/features/weather/domain/entities/weather_list.dart';

import '../../../fixtures/json_reader.dart';

void main() {
  final tWeatherModelList = WeatherModelList([
    WeatherModel(
      time: DateTime.parse("2022-08-01T19:15:00.000Z"),
      tempRaw: 24.0,
      humRaw: 81.1,
      presRaw: 1014.2,
      lux: 55.1,
    ),
    WeatherModel(
      time: DateTime.parse("2022-08-02T15:30:00.000Z"),
      tempRaw: 24.0,
      humRaw: 81.1,
      presRaw: 1014.2,
      lux: 55.1,
    ),
    WeatherModel(
      time: DateTime.parse("2022-08-02T18:10:00.000Z"),
      tempRaw: 24.0,
      humRaw: 81.1,
      presRaw: 1014.2,
      lux: 55.1,
    ),
    WeatherModel(
      time: DateTime.parse("2022-08-04T20:15:00.000Z"),
      tempRaw: 24.0,
      humRaw: 81.1,
      presRaw: 1014.2,
      lux: 55.1,
    ),
    WeatherModel(
      time: DateTime.parse("2022-08-08T20:15:00.000Z"),
      tempRaw: 24.0,
      humRaw: 81.1,
      presRaw: 1014.2,
      lux: 55.1,
    ),
  ]);

  test(
    'WeatherModelList should be a subclass of WeatherList',
    () async {
      expect(tWeatherModelList, isA<WeatherList>());
    },
  );

  group('fromJson', () {
    // Testing for weather_weekly.json fixture
    test('should return a valid WeatherModelList from JSON payload', () {
      final Map<String, dynamic> jsonObj =
          jsonDecode(readFixture('weather_weekly.json'));
      final result = WeatherModelList.fromJson(jsonObj);
      expect(result, tWeatherModelList);
    });
  });
  group('toJson', () {
    test('should return a JSON with proper data from WeatherModelList', () {
      final result = tWeatherModelList.toJson();
      // get first WeatherModel object from JSON to test against
      final Map<String, dynamic> expectedJson =
          jsonDecode(readFixture('weather_weekly.json'));
      expect(result, expectedJson);
    });
  });
}
