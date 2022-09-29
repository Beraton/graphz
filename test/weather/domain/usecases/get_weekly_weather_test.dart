import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphz/core/usecases/usecase.dart';
import 'package:graphz/features/weather/domain/entities/weather.dart';
import 'package:graphz/features/weather/domain/entities/weather_list.dart';
import 'package:graphz/features/weather/domain/repositories/weather_repository.dart';
import 'package:graphz/features/weather/domain/usecases/get_weekly_weather.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_full_year_weather_test.mocks.dart';

@GenerateMocks([WeatherRepository])
void main() {
  late GetWeeklyWeather usecase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetWeeklyWeather(mockWeatherRepository);
  });

  final tResponse = WeatherList([
    Weather(
        time: DateTime.now().subtract(const Duration(days: 3)),
        tempRaw: 24.526027397260272,
        humRaw: 49.527611301369866,
        presRaw: 1024.4455655209517,
        lux: 228.13698630136986),
    Weather(
        time: DateTime.now().subtract(const Duration(days: 2)),
        tempRaw: 27.526027397260272,
        humRaw: 51.527611301369866,
        presRaw: 1023.4455655209517,
        lux: 329.13698630136986),
  ]);

  test(
    'should get last week weather data available from repository',
    () async {
      when(mockWeatherRepository.getWeeklyWeather())
          .thenAnswer((_) async => Right(tResponse));
      final result = await usecase(NoParams());

      expect(result, Right(tResponse));
      verify(mockWeatherRepository.getWeeklyWeather());
      verifyNoMoreInteractions(mockWeatherRepository);
    },
  );
}
