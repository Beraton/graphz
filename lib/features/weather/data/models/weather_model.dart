import '../../domain/entities/weather.dart';

class WeatherModel extends Weather {
  WeatherModel({
    required DateTime time,
    required num tempRaw,
    required num humRaw,
    required num presRaw,
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

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      time: DateTime.parse(json['time']),
      tempRaw: json['mean_temperature'],
      humRaw: json['mean_humidity'],
      presRaw: json['mean_pressure'],
      lux: json['mean_light'],
    );
  }
}
