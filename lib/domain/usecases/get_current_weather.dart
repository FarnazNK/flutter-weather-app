import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

@lazySingleton
class GetCurrentWeather implements UseCase<Weather, GetCurrentWeatherParams> {
  final WeatherRepository repository;

  GetCurrentWeather(this.repository);

  @override
  Future<Either<Failure, Weather>> call(GetCurrentWeatherParams params) async {
    return await repository.getCurrentWeather(params.cityName);
  }
}

class GetCurrentWeatherParams {
  final String cityName;

  GetCurrentWeatherParams({required this.cityName});
}
