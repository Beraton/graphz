import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphz/core/errors/exceptions.dart';
import 'package:graphz/features/weather/data/datasources/weather_remote_datasource.dart';
import 'package:graphz/features/weather/data/models/weather_model_list.dart';
import 'package:graphz/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../fixtures/json_reader.dart';
import 'weather_remote_datasource_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late WeatherRemoteDatasourceImpl dataSource;
  late MockClient mockHttpClient;

  void setUpMockHttpClientSuccess() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(readFixture('weather_mixed.json'), 200));
  }

  void setUpMockHttpClientFailure() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = WeatherRemoteDatasourceImpl(client: mockHttpClient);
  });

  group('getFullYearWeather', () {
    test('should perform GET request to an API', () async {
      setUpMockHttpClientSuccess();
      dataSource.getFullYearWeather();
      verify(
        mockHttpClient.get(
          Uri.http('10.0.2.2:5000', '/api/weather'),
          headers: {'Content-Type': 'application/json'},
        ),
      );
    });
    test(
        'should return WeatherModelList when the GET request to the API was successful (200)',
        () async {
      final tWeatherList = WeatherModelList.fromJson(
          json.decode(readFixture('weather_mixed.json')));
      setUpMockHttpClientSuccess();
      final result = await dataSource.getFullYearWeather();
      expect(result, equals(tWeatherList));
    });
    test(
        'should throw ServerException when the GET request to the API was unsuccessful (404)',
        () async {
      setUpMockHttpClientFailure();
      final call = dataSource.getFullYearWeather();
      expect(() => call, throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('getWeeklyYearWeather', () {
    test('should perform GET request to an API', () async {
      setUpMockHttpClientSuccess();
      dataSource.getWeeklyWeather();
      verify(
        mockHttpClient.get(
          Uri.http('10.0.2.2:5000', '/api/weather/weekly'),
          headers: {'Content-Type': 'application/json'},
        ),
      );
    });
    test(
        'should return WeatherModelList when the GET request to the API was successful (200)',
        () async {
      final tWeatherList = WeatherModelList.fromJson(
          json.decode(readFixture('weather_mixed.json')));
      setUpMockHttpClientSuccess();
      final result = await dataSource.getWeeklyWeather();
      expect(result, equals(tWeatherList));
    });
    test(
        'should throw ServerException when the GET request to the API was unsuccessful (404)',
        () async {
      setUpMockHttpClientFailure();
      final call = dataSource.getFullYearWeather();
      expect(() => call, throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
