# Architecture Documentation

This document describes the architecture and design patterns used in the Flutter Weather App.

## Overview

The application follows **Clean Architecture** principles with clear separation of concerns and dependencies flowing inward. The architecture is divided into three main layers:

1. **Presentation Layer** (UI)
2. **Domain Layer** (Business Logic)
3. **Data Layer** (Data Access)

```
┌─────────────────────────────────────────────────────────┐
│                   Presentation Layer                     │
│  ┌────────────┐  ┌────────────┐  ┌────────────────┐    │
│  │   Pages    │  │   Widgets  │  │  BLoC/State    │    │
│  └────────────┘  └────────────┘  └────────────────┘    │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│                     Domain Layer                         │
│  ┌────────────┐  ┌────────────┐  ┌────────────────┐    │
│  │  Entities  │  │  Use Cases │  │  Repositories  │    │
│  │            │  │            │  │  (Interfaces)  │    │
│  └────────────┘  └────────────┘  └────────────────┘    │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│                      Data Layer                          │
│  ┌────────────┐  ┌────────────┐  ┌────────────────┐    │
│  │   Models   │  │Data Sources│  │  Repositories  │    │
│  │            │  │ Remote/Loc │  │(Implementation)│    │
│  └────────────┘  └────────────┘  └────────────────┘    │
└─────────────────────────────────────────────────────────┘
```

## Layers

### 1. Presentation Layer

**Responsibility:** Display data and handle user interactions

**Components:**
- **Pages:** Full-screen UI components
- **Widgets:** Reusable UI components
- **BLoC:** Business Logic Component for state management

**Key Principles:**
- No direct dependency on data sources
- Depends only on domain layer
- Handles UI state and events
- Transforms domain entities to UI models

**Example:**
```dart
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeather getCurrentWeather;
  
  WeatherBloc({required this.getCurrentWeather});
  
  // BLoC handles UI events and updates state
}
```

### 2. Domain Layer

**Responsibility:** Contains business logic and rules

**Components:**
- **Entities:** Core business objects
- **Use Cases:** Application-specific business rules
- **Repository Interfaces:** Abstract data access

**Key Principles:**
- Independent of frameworks
- No external dependencies
- Pure Dart code
- Contains business rules

**Example:**
```dart
class Weather extends Equatable {
  final String cityName;
  final double temperature;
  // ... business entity properties
}

class GetCurrentWeather implements UseCase<Weather, GetCurrentWeatherParams> {
  final WeatherRepository repository;
  
  Future<Either<Failure, Weather>> call(GetCurrentWeatherParams params);
}
```

### 3. Data Layer

**Responsibility:** Manage data from various sources

**Components:**
- **Models:** Data transfer objects
- **Data Sources:** Remote (API) and Local (Cache)
- **Repository Implementations:** Concrete data access

**Key Principles:**
- Implements domain repository interfaces
- Handles data transformation
- Manages caching strategy
- Error handling and mapping

**Example:**
```dart
class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource;
  
  Future<Either<Failure, Weather>> getCurrentWeather(String city) {
    // Fetch from API, cache locally, handle errors
  }
}
```

## Design Patterns

### 1. Repository Pattern

**Purpose:** Abstract data sources from business logic

**Implementation:**
```dart
// Domain (Interface)
abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather(String city);
}

// Data (Implementation)
class WeatherRepositoryImpl implements WeatherRepository {
  // Implementation details
}
```

**Benefits:**
- Decouples data access from business logic
- Easy to mock for testing
- Flexible data source switching

### 2. BLoC Pattern

**Purpose:** Separate business logic from UI

**Implementation:**
```dart
// Events
abstract class WeatherEvent {}
class GetWeatherForCity extends WeatherEvent {
  final String cityName;
}

// States
abstract class WeatherState {}
class WeatherLoaded extends WeatherState {
  final Weather weather;
}

// BLoC
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  // Handle events, emit states
}
```

**Benefits:**
- Predictable state management
- Easy to test
- Reactive programming
- Clear separation of concerns

### 3. Dependency Injection

**Purpose:** Manage object creation and dependencies

**Implementation:**
```dart
@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio() => Dio(BaseOptions(...));
}

@LazySingleton(as: WeatherRepository)
class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  
  WeatherRepositoryImpl({required this.remoteDataSource});
}
```

**Benefits:**
- Loose coupling
- Easy testing with mocks
- Centralized configuration
- Automatic dependency resolution

### 4. Use Case Pattern

**Purpose:** Encapsulate business logic operations

**Implementation:**
```dart
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class GetCurrentWeather implements UseCase<Weather, GetCurrentWeatherParams> {
  final WeatherRepository repository;
  
  GetCurrentWeather(this.repository);
  
  @override
  Future<Either<Failure, Weather>> call(GetCurrentWeatherParams params) {
    return repository.getCurrentWeather(params.cityName);
  }
}
```

**Benefits:**
- Single responsibility
- Reusable business logic
- Easy to test
- Clear intent

## Error Handling

### Failure Hierarchy

```dart
abstract class Failure {
  final String message;
}

class ServerFailure extends Failure {}
class NetworkFailure extends Failure {}
class CacheFailure extends Failure {}
```

### Either Type

Using `dartz` for functional error handling:

```dart
Future<Either<Failure, Weather>> getCurrentWeather(String city) {
  try {
    final weather = await remoteDataSource.getWeather(city);
    return Right(weather);
  } catch (e) {
    return Left(ServerFailure('Failed to get weather'));
  }
}
```

**Benefits:**
- Type-safe error handling
- Forces error consideration
- No uncaught exceptions
- Clear success/failure paths

## State Management Flow

```
User Action (UI)
       │
       ▼
  BLoC Event
       │
       ▼
  Use Case
       │
       ▼
  Repository
       │
       ├──▶ Remote Data Source (API)
       │
       └──▶ Local Data Source (Cache)
       │
       ▼
 Either<Failure, Data>
       │
       ▼
  BLoC State
       │
       ▼
   UI Update
```

## Testing Strategy

### Unit Tests
- Test use cases in isolation
- Mock repositories
- Test business logic

### Widget Tests
- Test UI components
- Mock BLoC states
- Verify UI behavior

### Integration Tests
- Test complete flows
- Real dependencies
- End-to-end scenarios

### BLoC Tests
```dart
blocTest<WeatherBloc, WeatherState>(
  'emits [Loading, Loaded] when data is fetched',
  build: () => WeatherBloc(getCurrentWeather: mockUseCase),
  act: (bloc) => bloc.add(GetWeatherForCity('London')),
  expect: () => [
    WeatherLoading(),
    WeatherLoaded(weather),
  ],
);
```

## Code Generation

### Freezed (Immutable Models)
```dart
@freezed
class WeatherModel with _$WeatherModel {
  const factory WeatherModel({
    required String name,
    required double temp,
  }) = _WeatherModel;
  
  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
}
```

### Injectable (Dependency Injection)
```dart
@injectable
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeather getCurrentWeather;
  
  WeatherBloc({required this.getCurrentWeather});
}
```

### Retrofit (API Client)
```dart
@RestApi()
abstract class WeatherRemoteDataSource {
  @GET('/weather')
  Future<WeatherModel> getCurrentWeather(@Query('q') String city);
}
```

## Best Practices

1. **Separation of Concerns**: Each layer has a specific responsibility
2. **Dependency Rule**: Dependencies point inward (toward domain)
3. **Interface Segregation**: Small, focused interfaces
4. **Single Responsibility**: Each class has one reason to change
5. **Open/Closed**: Open for extension, closed for modification
6. **Testability**: All components are easily testable
7. **Immutability**: Use immutable data structures
8. **Type Safety**: Leverage Dart's type system
9. **Error Handling**: Handle all error cases explicitly
10. **Documentation**: Document complex business logic

## Future Enhancements

- Implement feature-based folder structure
- Add more use cases (forecast, historical data)
- Implement caching strategies
- Add offline-first architecture
- Implement pagination
- Add analytics
- Implement feature flags

## References

- [Clean Architecture by Robert C. Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [BLoC Pattern Documentation](https://bloclibrary.dev/)
- [Flutter Architecture Samples](https://github.com/brianegan/flutter_architecture_samples)
- [SOLID Principles](https://en.wikipedia.org/wiki/SOLID)
