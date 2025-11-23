import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/exceptions.dart';
import '../models/weather_model.dart';

abstract class WeatherLocalDataSource {
  Future<WeatherModel> getLastWeather();
  Future<void> cacheWeather(WeatherModel weatherModel);
}

@LazySingleton(as: WeatherLocalDataSource)
class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  static const String weatherBoxName = 'weather_box';
  static const String cachedWeatherKey = 'cached_weather';

  @override
  Future<WeatherModel> getLastWeather() async {
    try {
      final box = await Hive.openBox(weatherBoxName);
      final jsonString = box.get(cachedWeatherKey);
      
      if (jsonString != null) {
        final Map<String, dynamic> jsonMap = json.decode(jsonString);
        return WeatherModel.fromJson(jsonMap);
      } else {
        throw CacheException('No cached weather data found');
      }
    } catch (e) {
      throw CacheException('Failed to get cached weather: $e');
    }
  }

  @override
  Future<void> cacheWeather(WeatherModel weatherModel) async {
    try {
      final box = await Hive.openBox(weatherBoxName);
      final jsonString = json.encode(weatherModel.toJson());
      await box.put(cachedWeatherKey, jsonString);
    } catch (e) {
      throw CacheException('Failed to cache weather: $e');
    }
  }
}
