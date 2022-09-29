import '../../../features/weather/data/models/weather_model_list.dart';

class WeatherFilter {
  WeatherModelList filterWeeklyWeather(WeatherModelList inputWeather) {
    final result = WeatherModelList([]);
    const duration = Duration(days: 7);
    DateTime start = DateTime.now().subtract(duration);
    DateTime end = DateTime.now();
    for (int i = 0; i < inputWeather.weatherList.length; i++) {
      if (inputWeather.weatherList[i].time.isAfter(start) &&
          inputWeather.weatherList[i].time.isBefore(end)) {
        result.weatherList.add(inputWeather.weatherList[i]);
      }
    }
    return result;
  }
}
