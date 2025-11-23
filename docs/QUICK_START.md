# Quick Start Guide

This guide will help you get started with the Flutter Weather App quickly.

## Prerequisites

Before you begin, ensure you have the following installed:

- Flutter SDK (3.24 or higher)
- Dart SDK (3.0 or higher)
- Android Studio or VS Code with Flutter plugins
- Git
- (Optional) Xcode for iOS development (macOS only)

## Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/YOUR_USERNAME/flutter_weather_app.git
cd flutter_weather_app
```

### 2. Run Setup Script

The easiest way to set up the project:

```bash
chmod +x scripts/setup.sh
./scripts/setup.sh
```

Or manually:

```bash
# Get dependencies
flutter pub get

# Run code generation
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Get API Key

1. Visit [OpenWeatherMap](https://openweathermap.org/api)
2. Sign up for a free account
3. Generate an API key
4. Copy your API key

### 4. Configure API Key

Open `lib/core/constants/api_constants.dart` and add your API key:

```dart
static const String apiKey = 'YOUR_API_KEY_HERE';
```

### 5. Run the App

```bash
flutter run
```

## Development Workflow

### Code Generation

After modifying files with annotations (@freezed, @injectable, etc.):

```bash
./scripts/generate.sh
```

Or manually:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Running Tests

Run all tests with coverage:

```bash
./scripts/test.sh
```

Or manually:

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

### Building the App

Build for specific platforms:

```bash
# Android
./scripts/build.sh android

# iOS (macOS only)
./scripts/build.sh ios

# Web
./scripts/build.sh web

# All platforms
./scripts/build.sh all
```

## Project Structure

```
flutter_weather_app/
├── lib/
│   ├── core/               # Core utilities and configuration
│   │   ├── constants/      # App constants
│   │   ├── di/            # Dependency injection
│   │   ├── error/         # Error handling
│   │   ├── network/       # Network configuration
│   │   └── theme/         # App theming
│   ├── data/              # Data layer
│   │   ├── datasources/   # API and local data sources
│   │   ├── models/        # Data models
│   │   └── repositories/  # Repository implementations
│   ├── domain/            # Domain layer
│   │   ├── entities/      # Business entities
│   │   ├── repositories/  # Repository contracts
│   │   └── usecases/      # Business logic
│   └── presentation/      # Presentation layer
│       ├── bloc/          # BLoC state management
│       ├── pages/         # UI screens
│       └── widgets/       # Reusable widgets
├── test/                  # Tests
├── scripts/               # Development scripts
└── .github/              # GitHub workflows
```

## Common Commands

```bash
# Get dependencies
flutter pub get

# Format code
dart format .

# Analyze code
flutter analyze

# Run tests
flutter test

# Run tests with coverage
flutter test --coverage

# Clean build files
flutter clean

# Check for outdated packages
flutter pub outdated

# Upgrade packages
flutter pub upgrade
```

## Features

✅ Search weather by city name  
✅ Get weather for current location  
✅ Offline caching  
✅ Pull to refresh  
✅ Dark mode support  
✅ Error handling  
✅ Loading states  

## Troubleshooting

### API Key Not Working

- Ensure you've activated your API key on OpenWeatherMap
- Wait a few minutes after creating a new key (activation delay)
- Check that the key is correctly added to `api_constants.dart`

### Build Errors

```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Location Permission Issues

- Ensure location permissions are granted in device settings
- For iOS, check Info.plist for location permission descriptions
- For Android, check AndroidManifest.xml for location permissions

### Code Generation Issues

```bash
# Delete existing generated files and regenerate
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

## Next Steps

- Read the [Contributing Guide](CONTRIBUTING.md)
- Check the [README](README.md) for detailed information
- Review the [CHANGELOG](CHANGELOG.md) for version history
- Explore the codebase and architecture

## Support

- Create an issue on GitHub for bugs or feature requests
- Check existing issues for solutions
- Read the documentation in the code

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [BLoC Pattern](https://bloclibrary.dev/)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [OpenWeatherMap API](https://openweathermap.org/api)

Happy coding! 🚀
