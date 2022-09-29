import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphz/core/usecases/usecase.dart';
import 'package:graphz/features/weather/domain/entities/weather.dart';
import 'package:graphz/features/weather/domain/entities/weather_list.dart';
import 'package:graphz/features/weather/domain/repositories/weather_repository.dart';
import 'package:graphz/features/weather/domain/usecases/get_full_year_weather.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_full_year_weather_test.mocks.dart';

/* Instead of this approach, follow these steps (null-safety problem):
   - @GenerateMocks([MockClassToGenerate])
   - Run flutter pub run build_runner build and refresh files
   - Import newly generated mock file (*.mocks.dart)
*/

//class MockWeatherRepository extends Mock implements WeatherRepository {}

@GenerateMocks([WeatherRepository])
void main() {
  late GetFullYearWeather usecase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetFullYearWeather(mockWeatherRepository);
  });

  final tResponse = WeatherList([
    Weather(
        time: DateTime.parse("2022-08-09T11:00:00.000Z"),
        tempRaw: 24.526027397260272,
        humRaw: 49.527611301369866,
        presRaw: 1024.4455655209517,
        lux: 228.13698630136986),
    Weather(
        time: DateTime.parse("2022-08-09T11:30:00.000Z"),
        tempRaw: 27.526027397260272,
        humRaw: 51.527611301369866,
        presRaw: 1023.4455655209517,
        lux: 329.13698630136986),
  ]);

  test(
    'should get full year weather data available from repository',
    () async {
      when(mockWeatherRepository.getFullYearWeather())
          .thenAnswer((_) async => Right(tResponse));
      final result = await usecase(NoParams());

      expect(result, Right(tResponse));
      verify(mockWeatherRepository.getFullYearWeather());
      verifyNoMoreInteractions(mockWeatherRepository);
    },
  );
}
