import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphz/features/weather/data/models/weather_model.dart';
import 'package:graphz/features/weather/data/models/weather_model_list.dart';
import 'package:graphz/features/weather/domain/entities/weather_list.dart';

import '../../../fixtures/json_reader.dart';

void main() {
  final tWeatherModelList = WeatherModelList([
    WeatherModel(
      time: DateTime.parse("2022-08-13T20:15:46.198Z"),
      tempRaw: 24.01,
      humRaw: 81.1552734375,
      presRaw: 1014.2944341819934,
      lux: 55.01,
    ),
    WeatherModel(
      time: DateTime.parse("2022-08-17T20:17:46.198Z"),
      tempRaw: 25.1,
      humRaw: 76.1552734375,
      presRaw: 1015.2944341819934,
      lux: 49,
    ),
    WeatherModel(
      time: DateTime.parse("2022-08-21T20:17:46.198Z"),
      tempRaw: 26.1,
      humRaw: 80.1552734375,
      presRaw: 1020.2944341819934,
      lux: 51.5,
    ),
    WeatherModel(
      time: DateTime.parse("2022-08-27T20:17:46.198Z"),
      tempRaw: 19.1,
      humRaw: 79.1552734375,
      presRaw: 1019.2944341819934,
      lux: 81,
    ),
  ]);

  test(
    'WeatherModelList should be a subclass of WeatherList',
    () async {
      expect(tWeatherModelList, isA<WeatherList>());
    },
  );

  group('fromJson', () {
    test('should return a valid WeatherModelList from JSON payload', () {
      final Map<String, dynamic> jsonObj =
          jsonDecode(readFixture('weather_mixed.json'));
      final result = WeatherModelList.fromJson(jsonObj);
      //final result = tWeatherModel.fromJson(jsonMap);
      expect(result, tWeatherModelList);
    });
  });
  group('toJson', () {
    test('should return a JSON with proper data from WeatherModelList', () {
      final result = tWeatherModelList.toJson();
      // get first WeatherModel object from JSON to test against
      final Map<String, dynamic> expectedJson =
          jsonDecode(readFixture('weather_mixed.json'));
      expect(result, expectedJson);
    });
  });
}
