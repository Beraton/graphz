import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphz/core/errors/exceptions.dart';
import 'package:graphz/core/errors/failure.dart';
import 'package:graphz/core/network/network_info.dart';
import 'package:graphz/features/weather/data/datasources/weather_local_datasource.dart';
import 'package:graphz/features/weather/data/datasources/weather_remote_datasource.dart';
import 'package:graphz/features/weather/data/models/weather_model.dart';
import 'package:graphz/features/weather/data/models/weather_model_list.dart';
import 'package:graphz/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'weather_repository_impl_test.mocks.dart';

@GenerateMocks([WeatherRemoteDatasource, WeatherLocalDatasource, NetworkInfo])
void main() {
  late WeatherRepositoryImpl repository;
  late MockWeatherRemoteDatasource mockRemoteDatasource;
  late MockWeatherLocalDatasource mockLocalDatasource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDatasource = MockWeatherRemoteDatasource();
    mockLocalDatasource = MockWeatherLocalDatasource();
    mockNetworkInfo = MockNetworkInfo();
    repository = WeatherRepositoryImpl(
      remoteDatasource: mockRemoteDatasource,
      localDatasource: mockLocalDatasource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tWeatherModelList = WeatherModelList([
    WeatherModel(
        time: DateTime.parse("2022-08-13T20:15:46.198Z"),
        tempRaw: 24.01,
        humRaw: 81.15,
        presRaw: 1014.29,
        lux: 55.01),
  ]);

  // Helper function for running tests online
  void runTestsOnline(Function tests) {
    group('device state: online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      tests();
    });
  }

  // Helper function for running tests offline
  void runTestsOffine(Function tests) {
    group('device state: offine', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      tests();
    });
  }

  test('should check if device is online', () async {
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    when(mockRemoteDatasource.getFullYearWeather())
        .thenAnswer((_) async => tWeatherModelList);
    await repository.getFullYearWeather();
    verify(mockNetworkInfo.isConnected);
  });

  group('getFullYearWeather', () {
    runTestsOnline(() {
      test('should return remote data when call to remote API was successful',
          () async {
        when(mockRemoteDatasource.getFullYearWeather())
            .thenAnswer((_) async => tWeatherModelList);
        final result = await repository.getFullYearWeather();
        verify(mockRemoteDatasource.getFullYearWeather());
        expect(result, Right(tWeatherModelList));
      });

      test('should cache data when call to remote API was successful',
          () async {
        when(mockRemoteDatasource.getFullYearWeather())
            .thenAnswer((_) async => tWeatherModelList);
        await repository.getFullYearWeather();
        verify(mockRemoteDatasource.getFullYearWeather());
        verify(mockLocalDatasource.cacheWeeklyWeather(tWeatherModelList));
      });

      test(
          'should return server failure when call to remote API was unsuccessful',
          () async {
        when(mockRemoteDatasource.getFullYearWeather())
            .thenThrow(ServerException());
        final result = await repository.getFullYearWeather();
        verify(mockRemoteDatasource.getFullYearWeather());
        verifyZeroInteractions(mockLocalDatasource);
        expect(result, Left(ServerFailure()));
      });
    });

    runTestsOffine(() {
      test(
          'should return locally cached weekly weather data when it is present',
          () async {
        when(mockLocalDatasource.getCachedWeeklyWeather())
            .thenAnswer((_) async => (tWeatherModelList));
        final result = await repository.getFullYearWeather();
        verifyZeroInteractions(mockRemoteDatasource);
        verify(mockLocalDatasource.getCachedWeeklyWeather());
        expect(result, Right(tWeatherModelList));
      });

      test(
          'should return cache exception when there is no locally cached data present',
          () async {
        when(mockLocalDatasource.getCachedWeeklyWeather())
            .thenThrow(CacheException());
        final result = await repository.getFullYearWeather();
        verifyZeroInteractions(mockRemoteDatasource);
        verify(mockLocalDatasource.getCachedWeeklyWeather());
        expect(result, Left(CacheFailure()));
      });
    });
  });
}
