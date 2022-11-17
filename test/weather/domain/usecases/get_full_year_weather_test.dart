import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphz/core/usecases/usecase.dart';
import 'package:graphz/core/util/customizable_date_time.dart';
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

@GenerateMocks([WeatherRepository])
void main() {
  late GetFullYearWeather usecase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetFullYearWeather(mockWeatherRepository);
    CustomizableDateTime.customTime = DateTime(2010, 10, 10);
  });

  final tResponse = WeatherList([
    Weather(
        time: DateTime(2010, 6, 6),
        tempRaw: 24.5,
        humRaw: 49.5,
        presRaw: 1024.4,
        lux: 228.1),
    Weather(
        time: DateTime(2010, 4, 3),
        tempRaw: 27.5,
        humRaw: 51.5,
        presRaw: 1023.4,
        lux: 329.1)
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
