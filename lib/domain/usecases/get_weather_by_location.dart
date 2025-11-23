import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

@lazySingleton
class GetWeatherByLocation implements UseCase<Weather, LocationParams> {
  final WeatherRepository repository;

  GetWeatherByLocation(this.repository);

  @override
  Future<Either<Failure, Weather>> call(LocationParams params) async {
    return await repository.getCurrentWeatherByLocation(
      latitude: params.latitude,
      longitude: params.longitude,
    );
  }
}

class LocationParams {
  final double latitude;
  final double longitude;

  LocationParams({required this.latitude, required this.longitude});
}
