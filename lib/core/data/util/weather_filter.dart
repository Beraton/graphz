import '../../../features/weather/data/models/weather_model_list.dart';

class WeatherFilter {
  final WeatherModelList inputWeather;

  WeatherFilter(this.inputWeather);

  WeatherModelList filterWeeklyWeather() {
    final result = WeatherModelList([]);
    const duration = Duration(days: 7);
    DateTime start = DateTime.now().subtract(duration);
    DateTime end = DateTime.now();
    inputWeather.weatherList
        .where(
      (element) => element.time.isAfter(start) && element.time.isBefore(end),
    )
        .forEach((element) {
      result.weatherList.add(element);
    });
    return result;
  }
}
