import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphz/core/usecases/usecase.dart';
import 'package:graphz/core/util/customizable_date_time.dart';
import 'package:graphz/features/weather/domain/entities/weather.dart';
import 'package:graphz/features/weather/domain/entities/weather_list.dart';
import 'package:graphz/features/weather/domain/repositories/weather_repository.dart';
import 'package:graphz/features/weather/domain/usecases/get_selected_day_weather.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_selected_day_weather_test.mocks.dart';

@GenerateMocks([WeatherRepository])
void main() {
  late GetSelectedDayWeather usecase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetSelectedDayWeather(mockWeatherRepository);
    CustomizableDateTime.customTime = DateTime(2010, 10, 10);
  });

  final tResponse = WeatherList([
    Weather(
        time: DateTime.parse("2010-10-10T15:00:00.000Z"),
        tempRaw: 24.5,
        humRaw: 49.5,
        presRaw: 1024.4,
        lux: 228.1),
  ]);

  final String tDay = "2010-10-10";

  test(
    'should get selected day data available from repository',
    () async {
      when(mockWeatherRepository.getSelectedDayWeather(any))
          .thenAnswer((_) async => Right(tResponse));

      final result = await usecase(Params(selectedDay: tDay));

      expect(result, Right(tResponse));
      verify(mockWeatherRepository.getSelectedDayWeather(tDay));
      verifyNoMoreInteractions(mockWeatherRepository);
    },
  );
}
