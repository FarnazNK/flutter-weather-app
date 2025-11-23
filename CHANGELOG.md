# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-11-22

### Added
- Initial release of Flutter Weather App
- Clean architecture implementation with three layers (data, domain, presentation)
- BLoC pattern for state management
- Dependency injection using GetIt and Injectable
- OpenWeatherMap API integration
- Location services integration using Geolocator
- Local caching with Hive
- Search weather by city name
- Get weather for current location
- Beautiful UI with Material Design 3
- Dark mode support
- Error handling with user-friendly messages
- Pull to refresh functionality
- Loading states with shimmer effects
- Comprehensive unit tests for BLoC
- Widget tests for UI components
- CI/CD pipeline with GitHub Actions
- Code quality checks (formatting, analysis)
- Automated build for Android, iOS, and Web
- Code coverage reporting with Codecov
- Documentation (README, CONTRIBUTING)
- Development scripts (setup, test, build, generate)
- MIT License

### Architecture
- Data layer with remote and local data sources
- Domain layer with entities, repositories, and use cases
- Presentation layer with BLoC and widgets
- Repository pattern for data abstraction
- Error handling with Either type from dartz
- Freezed for immutable models
- Retrofit for type-safe API calls

### Dependencies
- flutter_bloc: State management
- get_it & injectable: Dependency injection
- dio & retrofit: Networking
- hive: Local storage
- freezed & json_serializable: Code generation
- geolocator: Location services
- dartz: Functional programming
- bloc_test & mocktail: Testing

### CI/CD
- Automated code formatting check
- Static code analysis
- Automated testing with coverage
- Multi-platform builds (Android, iOS, Web)
- Artifact uploads
- Coverage reporting

## [Unreleased]

### Planned Features
- 5-day weather forecast
- Weather maps integration
- Favorite locations
- Weather alerts
- Weather charts and graphs
- Multiple language support
- Weather widgets
- Share weather information
- Historical weather data
- Unit preference (Celsius/Fahrenheit)
