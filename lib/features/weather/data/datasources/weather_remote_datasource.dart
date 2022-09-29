import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:graphz/core/errors/exceptions.dart';

import '../../domain/entities/weather_list.dart';
import '../models/weather_model_list.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRemoteDatasource {
  Future<WeatherModelList> getWeeklyWeather();
  Future<WeatherModelList> getFullYearWeather();
}

class WeatherRemoteDatasourceImpl implements WeatherRemoteDatasource {
  final http.Client client;

  WeatherRemoteDatasourceImpl({required this.client});

  Future<WeatherModelList> _getWeatherFromUrl(Uri url) async {
    try {
      final response = await client.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return WeatherModelList.fromJson(json.decode(response.body));
      } else {
        throw ServerException();
      }
    } on SocketException {
      throw ServerException();
    }
  }

  @override
  Future<WeatherModelList> getFullYearWeather() =>
      _getWeatherFromUrl(Uri.http('10.0.2.2:5000', '/api/weather'));

  @override
  Future<WeatherModelList> getWeeklyWeather() =>
      _getWeatherFromUrl(Uri.http('10.0.2.2:5000', '/api/weather/weekly'));
}
