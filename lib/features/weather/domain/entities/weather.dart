import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final DateTime time;
  final double tempRaw;
  final double humRaw;
  final double presRaw;
  final num lux;

  Weather({
    required this.time,
    required this.tempRaw,
    required this.humRaw,
    required this.presRaw,
    required this.lux,
  });

  @override
  List<Object> get props => [time, tempRaw, humRaw, presRaw, lux];
}
