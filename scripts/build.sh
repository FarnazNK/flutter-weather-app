#!/bin/bash

# Build script for Flutter Weather App

echo "🏗️  Flutter Weather App Build Script"
echo ""

# Function to build Android
build_android() {
    echo "📱 Building Android APK..."
    flutter build apk --release
    
    if [ $? -eq 0 ]; then
        echo "✅ Android APK built successfully!"
        echo "📦 Location: build/app/outputs/flutter-apk/app-release.apk"
    else
        echo "❌ Android build failed!"
        return 1
    fi
}

# Function to build iOS
build_ios() {
    echo "🍎 Building iOS..."
    flutter build ios --release --no-codesign
    
    if [ $? -eq 0 ]; then
        echo "✅ iOS built successfully!"
    else
        echo "❌ iOS build failed!"
        return 1
    fi
}

# Function to build Web
build_web() {
    echo "🌐 Building Web..."
    flutter build web --release
    
    if [ $? -eq 0 ]; then
        echo "✅ Web built successfully!"
        echo "📦 Location: build/web/"
    else
        echo "❌ Web build failed!"
        return 1
    fi
}

# Parse command line arguments
if [ $# -eq 0 ]; then
    echo "Usage: ./build.sh [android|ios|web|all]"
    echo ""
    echo "Options:"
    echo "  android  - Build Android APK"
    echo "  ios      - Build iOS (macOS only)"
    echo "  web      - Build Web"
    echo "  all      - Build all platforms"
    exit 1
fi

case "$1" in
    android)
        build_android
        ;;
    ios)
        if [[ "$OSTYPE" != "darwin"* ]]; then
            echo "❌ iOS builds are only supported on macOS"
            exit 1
        fi
        build_ios
        ;;
    web)
        build_web
        ;;
    all)
        build_android
        echo ""
        if [[ "$OSTYPE" == "darwin"* ]]; then
            build_ios
            echo ""
        fi
        build_web
        ;;
    *)
        echo "❌ Invalid option: $1"
        echo "Usage: ./build.sh [android|ios|web|all]"
        exit 1
        ;;
esac

echo ""
echo "🎉 Build process completed!"
