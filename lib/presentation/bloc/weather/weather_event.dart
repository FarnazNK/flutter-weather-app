part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class GetWeatherForCity extends WeatherEvent {
  final String cityName;

  const GetWeatherForCity(this.cityName);

  @override
  List<Object> get props => [cityName];
}

class GetWeatherForCurrentLocation extends WeatherEvent {
  const GetWeatherForCurrentLocation();
}

class LoadCachedWeather extends WeatherEvent {
  const LoadCachedWeather();
}

class RefreshWeather extends WeatherEvent {
  const RefreshWeather();
}
