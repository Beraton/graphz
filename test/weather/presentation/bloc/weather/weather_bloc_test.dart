import 'package:dartz/dartz.dart';
import 'package:graphz/core/errors/failure.dart';
import 'package:graphz/core/usecases/usecase.dart';
import 'package:graphz/features/weather/domain/entities/weather.dart';
import 'package:graphz/features/weather/domain/entities/weather_list.dart';
import 'package:graphz/features/weather/domain/usecases/get_full_year_weather.dart';
import 'package:graphz/features/weather/domain/usecases/get_weekly_weather.dart';
import 'package:graphz/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'weather_bloc_test.mocks.dart';

const String SERVER_FAILURE_MESSAGE = 'Server failure';
const String CACHE_FAILURE_MESSAGE = 'Cache failure';

@GenerateMocks([GetFullYearWeather, GetWeeklyWeather])
void main() {
  late WeatherBloc bloc;
  late MockGetFullYearWeather mockGetFullYearWeather;
  late MockGetWeeklyWeather mockGetWeeklyWeather;

  setUp(() {
    mockGetFullYearWeather = MockGetFullYearWeather();
    mockGetWeeklyWeather = MockGetWeeklyWeather();
    bloc = WeatherBloc(
      fullYear: mockGetFullYearWeather,
      weeklyWeather: mockGetWeeklyWeather,
    );
  });

  final tWeatherList = WeatherList(
    [
      Weather(
          time: DateTime.parse("2022-08-30T11:00:00.000Z"),
          tempRaw: 24.0,
          humRaw: 49.0,
          presRaw: 1024.0,
          lux: 228.0),
      Weather(
          time: DateTime.parse("2022-08-30T12:00:00.000Z"),
          tempRaw: 24.0,
          humRaw: 49.0,
          presRaw: 1024.0,
          lux: 228.0),
      Weather(
          time: DateTime.parse("2022-08-30T13:00:00.000Z"),
          tempRaw: 24.0,
          humRaw: 49.0,
          presRaw: 1024.0,
          lux: 228.0),
    ],
  );

  test('bloc initialState should return Initial', () {
    expect(bloc.state, equals(Initial()));
  });

  group('GetFullYearWeather', () {
    test(
        'should emit [WeatherLoading, WeatherLoaded] when getting data was successful',
        () async {
      when(mockGetFullYearWeather(any))
          .thenAnswer((_) async => Right(tWeatherList));
      final expectedStates = [
        //Initial(),
        WeatherLoading(),
        WeatherLoaded(weather: tWeatherList),
      ];
      expectLater(bloc.stream, emitsInOrder(expectedStates));
      bloc.add(GetFullYearWeatherEvent());
    });

    test(
        'should emit [WeatherLoading, Error] when getting data was unsuccessful',
        () async {
      when(mockGetFullYearWeather(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      final expectedStates = [
        WeatherLoading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expectedStates));
      bloc.add(GetFullYearWeatherEvent());
    });

    test(
        'should emit [WeatherLoading, Error] with proper message stating what sort of error was encountered',
        () async {
      when(mockGetFullYearWeather(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      final expectedStates = [
        WeatherLoading(),
        Error(message: CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expectedStates));
      bloc.add(GetFullYearWeatherEvent());
    });
  });

  group('GetWeeklyWeather', () {
    test(
        'should emit [WeatherLoading, WeatherLoaded] when getting data was successful',
        () async {
      when(mockGetWeeklyWeather(any))
          .thenAnswer((_) async => Right(tWeatherList));
      final expectedStates = [
        //Initial(),
        WeatherLoading(),
        WeatherLoaded(weather: tWeatherList),
      ];
      expectLater(bloc.stream, emitsInOrder(expectedStates));
      bloc.add(GetLastWeekWeatherEvent());
    });

    test(
        'should emit [WeatherLoading, Error] when getting data was unsuccessful',
        () async {
      when(mockGetWeeklyWeather(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      final expectedStates = [
        WeatherLoading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expectedStates));
      bloc.add(GetLastWeekWeatherEvent());
    });

    test(
        'should emit [WeatherLoading, Error] with proper message stating what sort of error was encountered',
        () async {
      when(mockGetWeeklyWeather(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      final expectedStates = [
        WeatherLoading(),
        Error(message: CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expectedStates));
      bloc.add(GetLastWeekWeatherEvent());
    });
  });
}
