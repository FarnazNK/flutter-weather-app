import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_app/core/error/failures.dart';
import 'package:flutter_weather_app/domain/entities/weather.dart';
import 'package:flutter_weather_app/domain/usecases/get_current_weather.dart';
import 'package:flutter_weather_app/domain/usecases/get_weather_by_location.dart';
import 'package:flutter_weather_app/presentation/bloc/weather/weather_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCurrentWeather extends Mock implements GetCurrentWeather {}
class MockGetWeatherByLocation extends Mock implements GetWeatherByLocation {}

void main() {
  late WeatherBloc weatherBloc;
  late MockGetCurrentWeather mockGetCurrentWeather;
  late MockGetWeatherByLocation mockGetWeatherByLocation;

  setUp(() {
    mockGetCurrentWeather = MockGetCurrentWeather();
    mockGetWeatherByLocation = MockGetWeatherByLocation();
    weatherBloc = WeatherBloc(
      getCurrentWeather: mockGetCurrentWeather,
      getWeatherByLocation: mockGetWeatherByLocation,
    );
  });

  tearDown(() {
    weatherBloc.close();
  });

  const tWeather = Weather(
    cityName: 'London',
    temperature: 20.0,
    feelsLike: 18.0,
    humidity: 60,
    windSpeed: 5.0,
    description: 'Clear sky',
    icon: '01d',
    pressure: 1013,
    dateTime: 1234567890,
  );

  const tCityName = 'London';

  setUpAll(() {
    registerFallbackValue(GetCurrentWeatherParams(cityName: tCityName));
  });

  group('GetWeatherForCity', () {
    test('initial state should be WeatherInitial', () {
      expect(weatherBloc.state, equals(WeatherInitial()));
    });

    blocTest<WeatherBloc, WeatherState>(
      'should emit [WeatherLoading, WeatherLoaded] when data is gotten successfully',
      build: () {
        when(() => mockGetCurrentWeather(any()))
            .thenAnswer((_) async => const Right(tWeather));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const GetWeatherForCity(tCityName)),
      expect: () => [
        WeatherLoading(),
        const WeatherLoaded(tWeather),
      ],
      verify: (_) {
        verify(() => mockGetCurrentWeather(
              GetCurrentWeatherParams(cityName: tCityName),
            )).called(1);
      },
    );

    blocTest<WeatherBloc, WeatherState>(
      'should emit [WeatherLoading, WeatherError] when getting data fails',
      build: () {
        when(() => mockGetCurrentWeather(any()))
            .thenAnswer((_) async => const Left(ServerFailure('Server error')));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const GetWeatherForCity(tCityName)),
      expect: () => [
        WeatherLoading(),
        const WeatherError('Server error'),
      ],
    );
  });
}
