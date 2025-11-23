#!/bin/bash

# Setup script for Flutter Weather App

echo "🚀 Setting up Flutter Weather App..."
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed!"
    echo "Please install Flutter from: https://flutter.dev/docs/get-started/install"
    exit 1
fi

echo "✅ Flutter is installed"
flutter --version
echo ""

# Get Flutter dependencies
echo "📦 Getting Flutter dependencies..."
flutter pub get

if [ $? -ne 0 ]; then
    echo "❌ Failed to get dependencies!"
    exit 1
fi

echo "✅ Dependencies installed successfully!"
echo ""

# Run code generation
echo "🔄 Running code generation..."
flutter pub run build_runner build --delete-conflicting-outputs

if [ $? -ne 0 ]; then
    echo "❌ Code generation failed!"
    exit 1
fi

echo "✅ Code generation completed!"
echo ""

# Make scripts executable
echo "🔧 Making scripts executable..."
chmod +x scripts/*.sh

echo "✅ Scripts are now executable!"
echo ""

echo "📋 Next steps:"
echo "1. Get your free API key from: https://openweathermap.org/api"
echo "2. Add your API key to lib/core/constants/api_constants.dart"
echo "3. Run the app: flutter run"
echo ""
echo "🎉 Setup completed successfully!"
