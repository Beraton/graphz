import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphz/core/usecases/usecase.dart';
import 'package:graphz/core/util/customizable_date_time.dart';
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
    CustomizableDateTime.customTime = DateTime(2010, 10, 10);
  });

  final tResponse = WeatherList([
    Weather(
        time: DateTime(2010, 10, 7),
        tempRaw: 24.5,
        humRaw: 49.5,
        presRaw: 1024.4,
        lux: 228.1),
    Weather(
        time: DateTime(2010, 10, 5),
        tempRaw: 27.5,
        humRaw: 51.5,
        presRaw: 1023.4,
        lux: 329.1)
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
