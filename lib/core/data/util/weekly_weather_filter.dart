import '../../../features/weather/data/models/weather_model_list.dart';

class WeatherFilter {
  WeatherModelList filterWeeklyWeather(WeatherModelList inputWeather) {
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
    //print(result.weatherList.last);
    return result;
  }
}
