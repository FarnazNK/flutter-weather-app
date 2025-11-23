# Flutter Weather App

[![Flutter CI/CD](https://github.com/FarnazNK/flutter_weather_app/workflows/Flutter%20CI/CD/badge.svg)](https://github.com/FarnazNK/flutter_weather_app/actions)
[![codecov](https://codecov.io/gh/FarnazNK/flutter_weather_app/branch/main/graph/badge.svg)](https://codecov.io/gh/FarnazNK/flutter_weather_app)


A production-ready Flutter weather application showcasing clean architecture, BLoC pattern, comprehensive testing, and CI/CD best practices.

## Project Overview

This project demonstrates senior-level Flutter development skills with:

- **Clean Architecture** with clear separation of concerns
- **BLoC Pattern** for predictable state management
- **Dependency Injection** using GetIt and Injectable
- **Repository Pattern** with error handling
- **Comprehensive Testing** (Unit, Widget, Integration)
- **CI/CD Pipeline** with GitHub Actions
- **Code Quality** tools and standards
- **API Integration** with OpenWeatherMap
- **Local Caching** using Hive
- **Location Services** integration

## Architecture

```
lib/
├── core/
│   ├── constants/       # App-wide constants
│   ├── di/             # Dependency injection setup
│   ├── error/          # Error handling (failures, exceptions)
│   ├── network/        # Network configuration
│   ├── theme/          # App theming
│   └── usecases/       # Base usecase classes
├── data/
│   ├── datasources/    # Remote & Local data sources
│   ├── models/         # Data models with JSON serialization
│   └── repositories/   # Repository implementations
├── domain/
│   ├── entities/       # Business entities
│   ├── repositories/   # Repository interfaces
│   └── usecases/       # Business logic use cases
└── presentation/
    ├── bloc/           # BLoC state management
    ├── pages/          # UI screens
    └── widgets/        # Reusable widgets
```

## Features

- Search weather by city name
- Get weather for current location
- Offline caching
- Pull to refresh
- Beautiful UI with dark mode support
- Error handling with retry mechanism
- Loading states
- Comprehensive error messages

## Tech Stack

- **Flutter 3.24+**
- **Dart 3.0+**
- **State Management:** flutter_bloc
- **Dependency Injection:** get_it, injectable
- **Network:** dio, retrofit
- **Local Storage:** hive
- **Code Generation:** freezed, json_serializable, build_runner
- **Testing:** bloc_test, mocktail
- **Location:** geolocator
- **Functional Programming:** dartz

## Setup

### Prerequisites

- Flutter SDK 3.24 or higher
- Dart SDK 3.0 or higher
- Android Studio / VS Code
- Git

### Installation

1. Clone the repository:
```bash
git clone https://github.com/YOUR_USERNAME/flutter_weather_app.git
cd flutter_weather_app
```

2. Get dependencies:
```bash
flutter pub get
```

3. Get your free API key from [OpenWeatherMap](https://openweathermap.org/api)

4. Add your API key to `lib/core/constants/api_constants.dart`:
```dart
static const String apiKey = 'YOUR_API_KEY_HERE';
```

5. Run code generation:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

6. Run the app:
```bash
flutter run
```

## Testing

### Run all tests:
```bash
flutter test
```

### Run tests with coverage:
```bash
flutter test --coverage
```

### Run specific test file:
```bash
flutter test test/unit/weather_bloc_test.dart
```

## CI/CD

This project uses GitHub Actions for continuous integration and deployment:

### Workflow includes:
- Code formatting verification
- Static code analysis
- Automated testing with coverage
- Android APK build
- iOS build (no code signing)
- Web build
- Artifact uploads

### To enable CI/CD:
1. Fork this repository
2. Enable GitHub Actions in your repository settings
3. Push to main or develop branch to trigger the workflow

## Build

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## Code Quality

This project maintains high code quality standards:

- **Very Good Analysis** for strict linting rules
- **Code coverage** tracking with Codecov
- **Formatting** with `dart format`
- **Analysis** with `flutter analyze`
- **Pre-commit hooks** (recommended)

### Check code quality:
```bash
# Format code
dart format .

# Analyze code
flutter analyze

# Check for outdated dependencies
flutter pub outdated
```

## Design Patterns

- **Repository Pattern**: Abstraction of data sources
- **BLoC Pattern**: Separation of business logic and UI
- **Dependency Injection**: Loose coupling and testability
- **Factory Pattern**: Object creation in data sources
- **Singleton Pattern**: Network and DI instances

## Best Practices Implemented

1. **Clean Architecture** - Clear separation of layers
2. **SOLID Principles** - Maintainable and scalable code
3. **Error Handling** - Comprehensive failure handling
4. **Null Safety** - Type-safe code
5. **Code Generation** - Reduced boilerplate
6. **Immutability** - Using freezed for immutable models
7. **Testing** - High test coverage
8. **Documentation** - Well-documented code
9. **Version Control** - Meaningful commits
10. **CI/CD** - Automated workflows

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

**Your Name**
- GitHub: [@YOUR_USERNAME](https://github.com/YOUR_USERNAME)
- LinkedIn: [Your Profile](https://linkedin.com/in/YOUR_PROFILE)

## Acknowledgments

- [OpenWeatherMap](https://openweathermap.org/) for the weather API
- Flutter community for excellent packages
- Clean Architecture principles by Robert C. Martin

## Support

For support, email your.email@example.com or create an issue in the repository.

---

**If you found this project helpful, please give it a star!**
