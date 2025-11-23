import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/weather.dart';
import '../../../domain/usecases/get_current_weather.dart';
import '../../../domain/usecases/get_weather_by_location.dart';

part 'weather_event.dart';
part 'weather_state.dart';

@injectable
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeather getCurrentWeather;
  final GetWeatherByLocation getWeatherByLocation;

  Weather? _lastWeather;

  WeatherBloc({
    required this.getCurrentWeather,
    required this.getWeatherByLocation,
  }) : super(WeatherInitial()) {
    on<GetWeatherForCity>(_onGetWeatherForCity);
    on<GetWeatherForCurrentLocation>(_onGetWeatherForCurrentLocation);
    on<RefreshWeather>(_onRefreshWeather);
  }

  Future<void> _onGetWeatherForCity(
    GetWeatherForCity event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());

    final result = await getCurrentWeather(
      GetCurrentWeatherParams(cityName: event.cityName),
    );

    result.fold(
      (failure) => emit(WeatherError(failure.message)),
      (weather) {
        _lastWeather = weather;
        emit(WeatherLoaded(weather));
      },
    );
  }

  Future<void> _onGetWeatherForCurrentLocation(
    GetWeatherForCurrentLocation event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());

    try {
      // Check location permission
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        final newPermission = await Geolocator.requestPermission();
        if (newPermission == LocationPermission.denied ||
            newPermission == LocationPermission.deniedForever) {
          emit(const WeatherError('Location permission denied'));
          return;
        }
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition();

      final result = await getWeatherByLocation(
        LocationParams(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      );

      result.fold(
        (failure) => emit(WeatherError(failure.message)),
        (weather) {
          _lastWeather = weather;
          emit(WeatherLoaded(weather));
        },
      );
    } catch (e) {
      emit(WeatherError('Failed to get location: $e'));
    }
  }

  Future<void> _onRefreshWeather(
    RefreshWeather event,
    Emitter<WeatherState> emit,
  ) async {
    if (_lastWeather != null) {
      add(GetWeatherForCity(_lastWeather!.cityName));
    }
  }
}
