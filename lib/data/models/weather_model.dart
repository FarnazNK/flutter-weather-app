import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/weather.dart';

part 'weather_model.freezed.dart';
part 'weather_model.g.dart';

@freezed
class WeatherModel with _$WeatherModel {
  const WeatherModel._();

  const factory WeatherModel({
    required String name,
    required MainModel main,
    required List<WeatherInfoModel> weather,
    required WindModel wind,
    required int dt,
  }) = _WeatherModel;

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  Weather toEntity() {
    return Weather(
      cityName: name,
      temperature: main.temp,
      feelsLike: main.feelsLike,
      humidity: main.humidity,
      windSpeed: wind.speed,
      description: weather.first.description,
      icon: weather.first.icon,
      pressure: main.pressure,
      dateTime: DateTime.fromMillisecondsSinceEpoch(dt * 1000),
    );
  }
}

@freezed
class MainModel with _$MainModel {
  const factory MainModel({
    required double temp,
    @JsonKey(name: 'feels_like') required double feelsLike,
    required int humidity,
    required int pressure,
  }) = _MainModel;

  factory MainModel.fromJson(Map<String, dynamic> json) =>
      _$MainModelFromJson(json);
}

@freezed
class WeatherInfoModel with _$WeatherInfoModel {
  const factory WeatherInfoModel({
    required String main,
    required String description,
    required String icon,
  }) = _WeatherInfoModel;

  factory WeatherInfoModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherInfoModelFromJson(json);
}

@freezed
class WindModel with _$WindModel {
  const factory WindModel({
    required double speed,
  }) = _WindModel;

  factory WindModel.fromJson(Map<String, dynamic> json) =>
      _$WindModelFromJson(json);
}
