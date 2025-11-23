import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName);
  Future<Either<Failure, Weather>> getCurrentWeatherByLocation({
    required double latitude,
    required double longitude,
  });
  Future<Either<Failure, Weather>> getCachedWeather();
}
