import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:graphz/core/data/util/weather_filter.dart';
import 'package:graphz/core/errors/exceptions.dart';
import 'package:graphz/features/weather/data/models/weather_model.dart';
import 'package:hive/hive.dart';

import '../../domain/entities/weather_list.dart';
import '../models/weather_model_list.dart';

abstract class WeatherLocalDatasource {
  Future<WeatherModelList> getCachedWeeklyWeather();
  Future<void> cacheWeeklyWeather(WeatherModelList weatherToCache);
}

const cachedWeather = 'CACHED_WEATHER';

class WeatherLocalDatasourceImpl extends WeatherLocalDatasource {
  final HiveInterface hiveInterface;

  WeatherLocalDatasourceImpl({required this.hiveInterface});

  @override
  Future<void> cacheWeeklyWeather(WeatherModelList weatherToCache) async {
    final box = await _openBox(cachedWeather);
    final weatherFilter = WeatherFilter(weatherToCache);
    final filteredWeatherToCache = weatherFilter.filterWeeklyWeather().toJson();
    return box.put('weekly', filteredWeatherToCache);
  }

  @override
  Future<WeatherModelList> getCachedWeeklyWeather() async {
    //final jsonString = await hiveInterface.openBox(cachedWeather).get('weekly');
    final box = await _openBox(cachedWeather);
    //print(box.get('weekly'));
    final jsonObj = await box.get('weekly');
    if (jsonObj != null) {
      Map<String, dynamic> newJson = Map<String, dynamic>.from(jsonObj);
      //print(newJson['data'][newJson['data'].length - 1]);
      return Future.value(WeatherModelList.fromJson(newJson));
    } else {
      throw CacheException();
    }
  }

  Future<Box> _openBox(String name) async {
    try {
      final box = hiveInterface.openBox(name);
      return box;
    } catch (e) {
      throw CacheException();
    }
  }
}
