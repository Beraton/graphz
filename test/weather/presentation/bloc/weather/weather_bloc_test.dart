import 'package:dartz/dartz.dart';
import 'package:graphz/core/errors/failure.dart';
import 'package:graphz/core/usecases/usecase.dart';
import 'package:graphz/features/weather/domain/entities/weather.dart';
import 'package:graphz/features/weather/domain/entities/weather_list.dart';
import 'package:graphz/features/weather/domain/usecases/get_full_year_weather.dart';
import 'package:graphz/features/weather/domain/usecases/get_selected_day_weather.dart';
import 'package:graphz/features/weather/domain/usecases/get_weekly_weather.dart';
import 'package:graphz/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'weather_bloc_test.mocks.dart';

const String SERVER_FAILURE_MESSAGE = 'Server failure';
const String CACHE_FAILURE_MESSAGE = 'Cache failure';

@GenerateMocks([GetFullYearWeather, GetWeeklyWeather, GetSelectedDayWeather])
void main() {
  late WeatherBloc bloc;
  late MockGetFullYearWeather mockGetFullYearWeather;
  late MockGetWeeklyWeather mockGetWeeklyWeather;
  late MockGetSelectedDayWeather mockGetSelectedDayWeather;

  setUp(() {
    mockGetFullYearWeather = MockGetFullYearWeather();
    mockGetWeeklyWeather = MockGetWeeklyWeather();
    mockGetSelectedDayWeather = MockGetSelectedDayWeather();
    bloc = WeatherBloc(
      fullYear: mockGetFullYearWeather,
      weeklyWeather: mockGetWeeklyWeather,
      selectedDayWeather: mockGetSelectedDayWeather,
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
        WeatherLoading(),
        WeatherLoaded(weather: tWeatherList),
      ];
      expectLater(bloc.stream, emitsInOrder(expectedStates));
      bloc.add(GetFullYearWeatherEvent());
    });

    test(
        'should emit [WeatherLoading, Error] when getting data was unsuccessful with proper message',
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
        WeatherLoading(),
        WeatherLoaded(weather: tWeatherList),
      ];
      expectLater(bloc.stream, emitsInOrder(expectedStates));
      bloc.add(GetLastWeekWeatherEvent());
    });

    test(
        'should emit [WeatherLoading, Error] when getting data was unsuccessful with proper message',
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

  group('GetSelectedDayWeather', () {
    final tDate = DateTime(2022, 08, 01);
    final tSelectedDayWeather = WeatherList([
      Weather(
          time: DateTime.parse("2022-08-01T00:00:00.000Z"),
          tempRaw: 11.1,
          humRaw: 22.2,
          presRaw: 333.3,
          lux: 44.4)
    ]);

    test('should get data for selected date', () async {
      when(mockGetSelectedDayWeather(any))
          .thenAnswer((_) async => Right(tSelectedDayWeather));
      bloc.add(GetSelectedDayWeatherEvent(tDate));
      await untilCalled(mockGetSelectedDayWeather(any));
      verify(mockGetSelectedDayWeather(Params(selectedDay: tDate)));
    });

    test(
        'should emit [WeatherLoading, WeatherLoaded] when getting data was successful',
        () async {
      when(mockGetSelectedDayWeather(any))
          .thenAnswer((_) async => Right(tSelectedDayWeather));
      final expectedStates = [
        WeatherLoading(),
        WeatherLoaded(weather: tSelectedDayWeather),
      ];
      expectLater(bloc.stream, emitsInOrder(expectedStates));
      bloc.add(GetSelectedDayWeatherEvent(tDate));
    });

    test(
        'should emit [WeatherLoading, Error] when getting data was unsuccessful with proper message',
        () async {
      when(mockGetSelectedDayWeather(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      final expectedStates = [
        WeatherLoading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expectedStates));
      bloc.add(GetSelectedDayWeatherEvent(tDate));
    });

    test(
        'should emit [WeatherLoading, Error] with proper message stating what sort of error was encountered',
        () async {
      when(mockGetSelectedDayWeather(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      final expectedStates = [
        WeatherLoading(),
        Error(message: CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expectedStates));
      bloc.add(GetSelectedDayWeatherEvent(tDate));
    });
  });
}
