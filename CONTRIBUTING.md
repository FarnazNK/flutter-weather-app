# Contributing to Flutter Weather App

First off, thank you for considering contributing to Flutter Weather App! It's people like you that make this project such a great tool.

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible:

* **Use a clear and descriptive title**
* **Describe the exact steps to reproduce the problem**
* **Provide specific examples to demonstrate the steps**
* **Describe the behavior you observed and what behavior you expected**
* **Include screenshots if possible**
* **Include your environment details** (Flutter version, device, OS)

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

* **Use a clear and descriptive title**
* **Provide a detailed description of the suggested enhancement**
* **Explain why this enhancement would be useful**
* **List some examples of how it would be used**

### Pull Requests

* Fill in the required template
* Follow the Flutter style guide
* Include appropriate test cases
* Update documentation as needed
* End all files with a newline

## Development Process

1. **Fork the repository** and create your branch from `main`
2. **Make your changes** following our coding standards
3. **Add tests** for your changes
4. **Ensure the test suite passes** (`flutter test`)
5. **Format your code** (`dart format .`)
6. **Run the analyzer** (`flutter analyze`)
7. **Commit your changes** with a clear commit message
8. **Push to your fork** and submit a pull request

## Coding Standards

### Flutter Style Guide

* Follow the [official Dart style guide](https://dart.dev/guides/language/effective-dart/style)
* Use meaningful variable and function names
* Keep functions small and focused
* Add comments for complex logic
* Use trailing commas for better formatting

### Architecture

* Follow Clean Architecture principles
* Keep business logic in use cases
* Use BLoC pattern for state management
* Implement repository pattern for data access
* Write testable code

### Testing

* Write unit tests for business logic
* Write widget tests for UI components
* Maintain high code coverage (>80%)
* Use meaningful test descriptions
* Mock external dependencies

### Commit Messages

* Use present tense ("Add feature" not "Added feature")
* Use imperative mood ("Move cursor to..." not "Moves cursor to...")
* Limit first line to 72 characters
* Reference issues and pull requests

Example:
```
feat: add weather forecast feature

- Implement 5-day forecast API integration
- Create forecast display widget
- Add forecast bloc and states

Closes #123
```

### Commit Types

* `feat`: A new feature
* `fix`: A bug fix
* `docs`: Documentation only changes
* `style`: Code style changes (formatting, semicolons, etc.)
* `refactor`: Code change that neither fixes a bug nor adds a feature
* `perf`: Performance improvements
* `test`: Adding or updating tests
* `chore`: Changes to build process or auxiliary tools

## Project Structure

```
lib/
├── core/           # Core functionality, utilities
├── data/           # Data layer (models, repositories, data sources)
├── domain/         # Domain layer (entities, use cases)
└── presentation/   # Presentation layer (UI, BLoC)
```

## Code Generation

After making changes to files with annotations (@freezed, @injectable, etc.), run:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Questions?

Feel free to open an issue with your question or reach out to the maintainers.

Thank you for your contribution! 🎉
