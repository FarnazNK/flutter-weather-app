#!/bin/bash

# Script to run all tests with coverage for Flutter Weather App

echo "🧪 Running Flutter Tests..."
echo ""

# Format check
echo "📝 Checking code formatting..."
dart format --set-exit-if-changed .

if [ $? -ne 0 ]; then
    echo "❌ Code formatting check failed!"
    echo "Run 'dart format .' to fix formatting issues."
    exit 1
fi

echo "✅ Code formatting check passed!"
echo ""

# Analyze code
echo "🔍 Analyzing code..."
flutter analyze

if [ $? -ne 0 ]; then
    echo "❌ Code analysis failed!"
    exit 1
fi

echo "✅ Code analysis passed!"
echo ""

# Run tests with coverage
echo "🧪 Running tests with coverage..."
flutter test --coverage --reporter expanded

if [ $? -ne 0 ]; then
    echo "❌ Tests failed!"
    exit 1
fi

echo ""
echo "✅ All tests passed!"
echo ""

# Generate coverage report (if lcov is installed)
if command -v lcov &> /dev/null; then
    echo "📊 Generating coverage report..."
    genhtml coverage/lcov.info -o coverage/html
    echo "✅ Coverage report generated in coverage/html/index.html"
else
    echo "ℹ️  Install lcov to generate HTML coverage report:"
    echo "   macOS: brew install lcov"
    echo "   Linux: sudo apt-get install lcov"
fi

echo ""
echo "🎉 All checks completed successfully!"
