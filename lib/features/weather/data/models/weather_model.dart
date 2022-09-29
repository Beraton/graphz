import '../../domain/entities/weather.dart';

class WeatherModel extends Weather {
  WeatherModel({
    required DateTime time,
    required double tempRaw,
    required double humRaw,
    required double presRaw,
    required num lux,
  }) : super(
          time: time,
          tempRaw: tempRaw,
          humRaw: humRaw,
          presRaw: presRaw,
          lux: lux,
        );

  Map<String, dynamic> toJson() {
    return {
      'time': time.toIso8601String(),
      'mean_temperature': tempRaw,
      'mean_humidity': humRaw,
      'mean_pressure': presRaw,
      'mean_light': lux
    };
  }

  /* create WeatherModel from JSON payload
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      time: json['data'][0]['time'],
      tempRaw: json['data'][0]['temperature'],
      humRaw: json['data'][0]['humidity'],
      presRaw: json['data'][0]['pressure'],
      lux: json['data'][0]['light'],
    );
  }
  */

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      time: DateTime.parse(json['time']),
      tempRaw: json['mean_temperature'],
      humRaw: json['mean_humidity'],
      presRaw: json['mean_pressure'],
      lux: json['mean_light'],
    );
  }
/*
  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'tempRaw': tempRaw,
      'humRaw': humRaw,
      'presRaw': presRaw,
      'lux': lux
    };
  }

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final List<WeatherModel> result = [];
    json['data'].forEach((it) => {
          result.add(WeatherModel(
            time: it['time'],
            tempRaw: it['temperature'],
            humRaw: it['humidity'],
            presRaw: it['pressure'],
            lux: it['light'],
          ))
        });
    return result;
  }
*/
}
