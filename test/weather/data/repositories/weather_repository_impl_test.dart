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

/*
class MockRemoteDatasource extends Mock implements WeatherRemoteDatasource {}

class MockLocalDatasource extends Mock implements WeatherLocalDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}
*/

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
        humRaw: 81.1552734375,
        presRaw: 1014.2944341819934,
        lux: 55.01),
  ]);

  //final Weather tWeather = tWeatherModel;

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
    // set up
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    when(mockRemoteDatasource.getFullYearWeather())
        .thenAnswer((_) async => tWeatherModelList);
    // act
    await repository.getFullYearWeather();
    // check
    verify(mockNetworkInfo.isConnected);
  });

  group('getFullYearWeather', () {
    runTestsOnline(() {
      test('should return remote data when call to remote API was successful',
          () async {
        // set up
        when(mockRemoteDatasource.getFullYearWeather())
            .thenAnswer((_) async => tWeatherModelList);
        // act
        final result = await repository.getFullYearWeather();
        // check
        verify(mockRemoteDatasource.getFullYearWeather());
        expect(result, Right(tWeatherModelList));
      });

      test('should cache data when call to remote API was successful',
          () async {
        // set up
        when(mockRemoteDatasource.getFullYearWeather())
            .thenAnswer((_) async => tWeatherModelList);
        // act
        await repository.getFullYearWeather();
        // check
        verify(mockRemoteDatasource.getFullYearWeather());
        verify(mockLocalDatasource.cacheWeeklyWeather(tWeatherModelList));
      });

      test(
          'should return server failure when call to remote API was unsuccessful',
          () async {
        // set up
        when(mockRemoteDatasource.getFullYearWeather())
            .thenThrow(ServerException());
        // act
        final result = await repository.getFullYearWeather();
        // check
        verify(mockRemoteDatasource.getFullYearWeather());
        verifyZeroInteractions(mockLocalDatasource);
        expect(result, Left(ServerFailure()));
      });
    });

    runTestsOffine(() {
      test(
          'should return locally cached weekly weather data when it is present',
          () async {
        // set up
        when(mockLocalDatasource.getCachedWeeklyWeather())
            .thenAnswer((_) async => (tWeatherModelList));
        // act
        final result = await repository.getFullYearWeather();
        // check
        verifyZeroInteractions(mockRemoteDatasource);
        verify(mockLocalDatasource.getCachedWeeklyWeather());
        expect(result, Right(tWeatherModelList));
      });

      test(
          'should return cache exception when there is no locally cached data present',
          () async {
        // set up
        when(mockLocalDatasource.getCachedWeeklyWeather())
            .thenThrow(CacheException());
        // act
        final result = await repository.getFullYearWeather();
        // check
        verifyZeroInteractions(mockRemoteDatasource);
        verify(mockLocalDatasource.getCachedWeeklyWeather());
        expect(result, Left(CacheFailure()));
      });
    });
  });
}
