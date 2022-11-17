import 'package:dartz/dartz.dart';
import 'package:graphz/core/errors/failure.dart';
import 'package:graphz/core/usecases/usecase.dart';
import 'package:graphz/core/util/customizable_date_time.dart';
import 'package:graphz/core/util/input_date_converter.dart';
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
const String INVALID_INPUT_DATE_MESSAGE =
    'Weather for provided date cannot be fetched';

@GenerateMocks([
  GetFullYearWeather,
  GetWeeklyWeather,
  GetSelectedDayWeather,
  InputDateConverter
])
void main() {
  late WeatherBloc bloc;
  late MockGetFullYearWeather mockGetFullYearWeather;
  late MockGetWeeklyWeather mockGetWeeklyWeather;
  late MockGetSelectedDayWeather mockGetSelectedDayWeather;
  late MockInputDateConverter mockInputDateConverter;

  setUp(() {
    mockGetFullYearWeather = MockGetFullYearWeather();
    mockGetWeeklyWeather = MockGetWeeklyWeather();
    mockGetSelectedDayWeather = MockGetSelectedDayWeather();
    mockInputDateConverter = MockInputDateConverter();
    bloc = WeatherBloc(
      fullYear: mockGetFullYearWeather,
      weeklyWeather: mockGetWeeklyWeather,
      selectedDayWeather: mockGetSelectedDayWeather,
      inputDateConverter: mockInputDateConverter,
    );
    CustomizableDateTime.customTime = DateTime(2010, 10, 10);
  });

  final tWeatherList = WeatherList(
    [
      Weather(
          time: DateTime(2010, 10, 9),
          tempRaw: 24.0,
          humRaw: 49.0,
          presRaw: 1024.0,
          lux: 228.0),
      Weather(
          time: DateTime(2010, 10, 7),
          tempRaw: 24.0,
          humRaw: 49.0,
          presRaw: 1024.0,
          lux: 228.0),
      Weather(
          time: DateTime(2010, 10, 5),
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
    final tDate = DateTime(2010, 10, 10);
    final tParsedDate = "2010-10-10";
    final tSelectedDayWeather = WeatherList([
      Weather(
          time: tDate, tempRaw: 11.1, humRaw: 22.2, presRaw: 333.3, lux: 44.4)
    ]);

    void setUpMockInputDateConverterSuccess() =>
        when(mockInputDateConverter.parseDateToString(any))
            .thenReturn(Right(tParsedDate));
    test(
      'should call the InputDateConverter to convert the date to a proper string',
      () async {
        setUpMockInputDateConverterSuccess();
        when(mockGetSelectedDayWeather(any))
            .thenAnswer((_) async => Right(tSelectedDayWeather));
        bloc.add(GetSelectedDayWeatherEvent(tDate));
        await untilCalled(mockInputDateConverter.parseDateToString(any));
        verify(mockInputDateConverter.parseDateToString(tDate));
      },
    );

    test(
      'should emit [Error] when the input date is invalid',
      () async {
        when(mockInputDateConverter.parseDateToString(any))
            .thenReturn(Left(InvalidDateFailure()));
        final expected = [
          WeatherLoading(),
          Error(message: INVALID_INPUT_DATE_MESSAGE)
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
        bloc.add(GetSelectedDayWeatherEvent(tDate));
      },
    );
    test('should get data for selected date', () async {
      setUpMockInputDateConverterSuccess();
      when(mockGetSelectedDayWeather(any))
          .thenAnswer((_) async => Right(tSelectedDayWeather));
      bloc.add(GetSelectedDayWeatherEvent(tDate));
      await untilCalled(mockGetSelectedDayWeather(any));
      verify(mockGetSelectedDayWeather(Params(selectedDay: tParsedDate)));
    });

    test(
        'should emit [WeatherLoading, WeatherLoaded] when getting data was successful',
        () async {
      setUpMockInputDateConverterSuccess();
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
      setUpMockInputDateConverterSuccess();
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
      setUpMockInputDateConverterSuccess();
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
