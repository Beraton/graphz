import 'package:graphz/features/weather/data/models/weather_model.dart';

import '../../domain/entities/weather_list.dart';

// Q: is this even needed?
// - WeatherList accepts class type Weather which is extended by WeatherModel

//class WeatherModelList extends WeatherList {
class WeatherModelList extends WeatherList {
  final List<WeatherModel> weatherList;

  WeatherModelList(this.weatherList) : super(weatherList);

  factory WeatherModelList.fromJson(Map<String, dynamic> json) {
    final res = WeatherModelList([]);
    for (int i = 0; i < json['data'].length; i++) {
      var temp = WeatherModel.fromJson(json['data'][i]);
      res.weatherList.add(temp);
    }
    return res;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> res = {"status": "success", "data": []};
    for (int i = 0; i < weatherList.length; i++) {
      res['data'].add(weatherList[i].toJson());
    }
    return res;
  }
}
