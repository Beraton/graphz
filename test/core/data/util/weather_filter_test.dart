import 'package:graphz/core/data/util/weather_filter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphz/features/weather/data/models/weather_model.dart';
import 'package:graphz/features/weather/data/models/weather_model_list.dart';

final date1 = DateTime.now().subtract(const Duration(days: 10));
final date2 = DateTime.now().subtract(const Duration(days: 8));
final date3 = DateTime.now().subtract(const Duration(days: 3));
final date4 = DateTime.now();

final tExapleWeatherModelList = WeatherModelList(
  [
    WeatherModel(
      time: date1,
      tempRaw: 24.01,
      humRaw: 81.1552734375,
      presRaw: 1014.2944341819934,
      lux: 55.01,
    ),
    WeatherModel(
      time: date2,
      tempRaw: 24.01,
      humRaw: 81.1552734375,
      presRaw: 1014.2944341819934,
      lux: 55.01,
    ),
    WeatherModel(
      time: date3,
      tempRaw: 24.01,
      humRaw: 81.1552734375,
      presRaw: 1014.2944341819934,
      lux: 55.01,
    ),
    WeatherModel(
      time: date4,
      tempRaw: 24.01,
      humRaw: 81.1552734375,
      presRaw: 1014.2944341819934,
      lux: 55.01,
    ),
  ],
);

final tExpectedFilteredWeather = WeatherModelList(
  [
    WeatherModel(
      // 3 days ago
      time: date3,
      tempRaw: 24.01,
      humRaw: 81.1552734375,
      presRaw: 1014.2944341819934,
      lux: 55.01,
    ),
    WeatherModel(
      // today
      time: date4,
      tempRaw: 24.01,
      humRaw: 81.1552734375,
      presRaw: 1014.2944341819934,
      lux: 55.01,
    ),
  ],
);

void main() {
  late WeatherFilter weatherFilter;
  setUp(() {
    weatherFilter = WeatherFilter(tExapleWeatherModelList);
  });

  test('should return only weather records from the past 7 days', () {
    final result = weatherFilter.filterWeeklyWeather();
    expect(result, tExpectedFilteredWeather);
  });
}
