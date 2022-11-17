import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphz/core/data/util/weather_filter.dart';
import 'package:graphz/core/errors/exceptions.dart';
import 'package:graphz/core/util/customizable_date_time.dart';
import 'package:graphz/features/weather/data/datasources/weather_local_datasource.dart';
import 'package:graphz/features/weather/data/models/weather_model.dart';
import 'package:graphz/features/weather/data/models/weather_model_list.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/json_reader.dart';
import 'weather_local_datasource_test.mocks.dart';

@GenerateMocks([HiveInterface, Box])
void main() {
  late WeatherLocalDatasourceImpl dataSource;
  late MockHiveInterface mockHiveInterface;
  late MockBox mockHiveBox;

  void setUpMockHiveInterfaceAndBoxContent(Map<String, dynamic>? json) {
    when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockHiveBox);
    when(mockHiveBox.get('weekly')).thenAnswer((_) async => json);
  }

  setUp(() {
    mockHiveInterface = MockHiveInterface();
    mockHiveBox = MockBox();
    dataSource = WeatherLocalDatasourceImpl(
      hiveInterface: mockHiveInterface,
    );
    CustomizableDateTime.customTime = DateTime(2010, 10, 10);
  });

  final date1 = DateTime(2010, 10, 3);
  final date2 = DateTime(2010, 10, 4);
  final date3 = DateTime(2010, 10, 8);
  final date4 = DateTime(2010, 10, 9);

  final tWeatherModelList = WeatherModelList(
    [
      WeatherModel(
        time: date1,
        tempRaw: 24.01,
        humRaw: 81.15,
        presRaw: 1014.29,
        lux: 55.01,
      ),
      WeatherModel(
        time: date2,
        tempRaw: 24.01,
        humRaw: 81.15,
        presRaw: 1014.29,
        lux: 55.01,
      ),
      WeatherModel(
        time: date3,
        tempRaw: 24.01,
        humRaw: 81.15,
        presRaw: 1014.29,
        lux: 55.01,
      ),
      WeatherModel(
        time: date4,
        tempRaw: 24.01,
        humRaw: 81.15,
        presRaw: 1014.29,
        lux: 55.01,
      ),
    ],
  );

  final tExpectedResult = WeatherModelList([
    WeatherModel(
      time: date3,
      tempRaw: 24.01,
      humRaw: 81.15,
      presRaw: 1014.29,
      lux: 55.01,
    ),
    WeatherModel(
      time: date4,
      tempRaw: 24.01,
      humRaw: 81.15,
      presRaw: 1014.29,
      lux: 55.01,
    ),
  ]);

  group('getWeeklyWeather', () {
    test('should return weekly Weather from Hive box when there is one in it',
        () async {
      setUpMockHiveInterfaceAndBoxContent(tExpectedResult.toJson());
      final result = await dataSource.getCachedWeeklyWeather();
      verify(mockHiveInterface.openBox('CACHED_WEATHER'));
      expect(result, tExpectedResult);
    });
    test(
        'should return CacheException when there is no cached Weather in Hive box',
        () async {
      setUpMockHiveInterfaceAndBoxContent(null);
      final call = dataSource.getCachedWeeklyWeather();
      verify(mockHiveInterface.openBox('CACHED_WEATHER'));
      expect(() => call, throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('cacheWeeklyWeather', () {
    test('should call Hive box to save the data', () async {
      when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockHiveBox);
      await dataSource.cacheWeeklyWeather(tWeatherModelList);
      verify(mockHiveBox.put('weekly', tExpectedResult.toJson()));
      verify(mockHiveInterface.openBox('CACHED_WEATHER'));
    });
  });
}
