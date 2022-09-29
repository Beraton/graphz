import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphz/features/weather/data/models/weather_model.dart';
import 'package:graphz/features/weather/domain/entities/weather.dart';

import '../../../fixtures/json_reader.dart';

void main() {
  final tWeatherModel = WeatherModel(
    time: DateTime.parse("2022-08-13T20:15:46.198Z"),
    tempRaw: 24.01,
    humRaw: 81.1552734375,
    presRaw: 1014.2944341819934,
    lux: 55.01,
  );

  /*
  final tWeatherModelList = [
    WeatherModel(
      time: "2022-08-13T20:15:46.198Z",
      tempRaw: 24.01,
      humRaw: 81.1552734375,
      presRaw: 1014.2944341819934,
      lux: 55.01,
    ),
    WeatherModel(
      time: "2022-08-13T20:17:46.198Z",
      tempRaw: 25.1,
      humRaw: 76.1552734375,
      presRaw: 1015.2944341819934,
      lux: 49,
    ),
  ];
  */

  test(
    'should be subclass of Weather entity',
    () async {
      expect(tWeatherModel, isA<Weather>());
    },
  );

  group('fromJson', () {
    test('should return a valid WeatherModel from JSON payload', () {
      // get first WeatherModel object from JSON to test against
      final Map<String, dynamic> jsonObj =
          jsonDecode(readFixture('weather_mixed.json'))['data'][0];
      final result = WeatherModel.fromJson(jsonObj);
      expect(result, tWeatherModel);
    });
  });
  group('toJson', () {
    test('should return a JSON with proper data from WeatherModel', () {
      final result = tWeatherModel.toJson();
      // get first WeatherModel object from JSON to test against
      final Map<String, dynamic> expectedJson =
          jsonDecode(readFixture('weather_mixed.json'))['data'][0];
      expect(result, expectedJson);
    });
  });
}
