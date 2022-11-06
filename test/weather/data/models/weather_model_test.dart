import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphz/features/weather/data/models/weather_model.dart';
import 'package:graphz/features/weather/domain/entities/weather.dart';

import '../../../fixtures/json_reader.dart';

void main() {
  final tWeatherModel = WeatherModel(
    time: DateTime.parse("2022-08-01T19:15:00.000Z"),
    tempRaw: 24.0,
    humRaw: 81.1,
    presRaw: 1014.2,
    lux: 55.1,
  );

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
