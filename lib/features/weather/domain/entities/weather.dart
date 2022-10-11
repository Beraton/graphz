import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final DateTime time;
  final num tempRaw;
  final num humRaw;
  final num presRaw;
  final num lux;

  Weather({
    required this.time,
    required this.tempRaw,
    required this.humRaw,
    required this.presRaw,
    required this.lux,
  });

  double get temperature => double.parse(tempRaw.toStringAsFixed(1));

  double get humidity => double.parse(humRaw.toStringAsFixed(1));

  double get pressure => double.parse(presRaw.toStringAsFixed(1));

  double get light => double.parse(light.toStringAsFixed(1));

  @override
  List<Object> get props => [time, tempRaw, humRaw, presRaw, lux];
}
