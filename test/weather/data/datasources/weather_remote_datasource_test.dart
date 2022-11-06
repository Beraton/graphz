import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphz/core/errors/exceptions.dart';
import 'package:graphz/features/weather/data/datasources/weather_remote_datasource.dart';
import 'package:graphz/features/weather/data/models/weather_model_list.dart';
import 'package:graphz/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:intl/intl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../fixtures/json_reader.dart';
import 'weather_remote_datasource_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late WeatherRemoteDatasourceImpl dataSource;
  late MockClient mockHttpClient;

  void setUpMockHttpClientSuccess(String file) {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(readFixture(file), 200));
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
      setUpMockHttpClientSuccess('weather_mixed.json');
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
      setUpMockHttpClientSuccess('weather_mixed.json');
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

  group('getWeeklyWeather', () {
    test('should perform GET request to an API', () async {
      setUpMockHttpClientSuccess('weather_weekly.json');
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
          json.decode(readFixture('weather_weekly.json')));
      setUpMockHttpClientSuccess('weather_weekly.json');
      final result = await dataSource.getWeeklyWeather();
      expect(result, equals(tWeatherList));
    });
    test(
        'should throw ServerException when the GET request to the API was unsuccessful (404)',
        () async {
      setUpMockHttpClientFailure();
      final call = dataSource.getWeeklyWeather();
      expect(() => call, throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('getSelectedDayWeather', () {
    // Picking up random day that is present in our fixture
    // In this case, method should return only the FIRST element of JSON payload
    final DateTime tDay = DateFormat("yyyy-MM-dd").parse('2022-08-02');

    test(
        'should perform GET request with correct selectedDay parameter to an API',
        () async {
      setUpMockHttpClientSuccess('weather_daily.json');
      dataSource.getSelectedDayWeather(tDay);
      verify(
        mockHttpClient.get(
          Uri.http('10.0.2.2:5000', '/api/weather/day/${tDay.toString()}'),
          headers: {'Content-Type': 'application/json'},
        ),
      );
    });

    test(
        'should return WeatherModelList when the GET request to the API was successful (200)',
        () async {
      final tWeatherList = WeatherModelList.fromJson(
          json.decode(readFixture('weather_daily.json')));
      setUpMockHttpClientSuccess('weather_daily.json');
      final result = await dataSource.getSelectedDayWeather(tDay);
      expect(result, equals(tWeatherList));
    });
    test(
        'should throw ServerException when the GET request to the API was unsuccessful (404)',
        () async {
      setUpMockHttpClientFailure();
      final call = dataSource.getSelectedDayWeather(tDay);
      expect(() => call, throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
