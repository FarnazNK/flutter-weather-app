import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../models/weather_model.dart';

part 'weather_remote_data_source.g.dart';

@lazySingleton
@RestApi()
abstract class WeatherRemoteDataSource {
  @factoryMethod
  factory WeatherRemoteDataSource(Dio dio) = _WeatherRemoteDataSource;

  @GET('/weather')
  Future<WeatherModel> getCurrentWeather(@Query('q') String cityName);

  @GET('/weather')
  Future<WeatherModel> getCurrentWeatherByCoordinates(
    @Query('lat') double latitude,
    @Query('lon') double longitude,
  );
}
