#!/bin/bash

# Script to run code generation for the Flutter Weather App

echo "🔄 Running code generation..."
echo ""

# Run build_runner
echo "📦 Running build_runner..."
flutter pub run build_runner build --delete-conflicting-outputs

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Code generation completed successfully!"
else
    echo ""
    echo "❌ Code generation failed!"
    exit 1
fi
