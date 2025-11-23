# Deployment Guide

This guide covers deploying the Flutter Weather App to various platforms and stores.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Android Deployment](#android-deployment)
3. [iOS Deployment](#ios-deployment)
4. [Web Deployment](#web-deployment)
5. [GitHub Pages](#github-pages)
6. [CI/CD Deployment](#cicd-deployment)

## Prerequisites

- Configured development environment
- Signed app certificates (for production)
- Developer accounts:
  - Google Play Console (Android)
  - Apple Developer (iOS)
  - Firebase or hosting service (Web)

## Android Deployment

### 1. Configure App Signing

Create a keystore:
```bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA \
  -keysize 2048 -validity 10000 -alias upload
```

### 2. Configure Gradle

Create `android/key.properties`:
```properties
storePassword=<password>
keyPassword=<password>
keyAlias=upload
storeFile=<path-to-keystore>/upload-keystore.jks
```

Update `android/app/build.gradle`:
```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    ...
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

### 3. Build Release APK/AAB

```bash
# Build APK
flutter build apk --release

# Build App Bundle (recommended for Play Store)
flutter build appbundle --release
```

### 4. Upload to Google Play

1. Go to [Google Play Console](https://play.google.com/console)
2. Create a new app
3. Upload the AAB file
4. Complete store listing
5. Submit for review

### 5. Version Management

Update version in `pubspec.yaml`:
```yaml
version: 1.0.1+2  # version+buildNumber
```

## iOS Deployment

### 1. Configure Xcode Project

Open `ios/Runner.xcworkspace` in Xcode:

1. Set Bundle Identifier
2. Configure Team
3. Set Deployment Target
4. Configure Capabilities

### 2. Configure App Icons and Launch Screen

- Add icons to `ios/Runner/Assets.xcassets/AppIcon.appiconset/`
- Configure LaunchScreen.storyboard

### 3. Build Release

```bash
# Build iOS release
flutter build ios --release

# Or build without code signing
flutter build ios --release --no-codesign
```

### 4. Create Archive in Xcode

1. Open Xcode
2. Product → Archive
3. Validate App
4. Distribute App
5. Upload to App Store Connect

### 5. Submit to App Store

1. Go to [App Store Connect](https://appstoreconnect.apple.com)
2. Complete app information
3. Add screenshots
4. Submit for review

## Web Deployment

### 1. Build Web Release

```bash
flutter build web --release --web-renderer html
```

### 2. Firebase Hosting

#### Install Firebase Tools
```bash
npm install -g firebase-tools
firebase login
```

#### Initialize Firebase
```bash
firebase init hosting
```

Configure `firebase.json`:
```json
{
  "hosting": {
    "public": "build/web",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ]
  }
}
```

#### Deploy
```bash
firebase deploy --only hosting
```

### 3. GitHub Pages

#### Update `web/index.html`

Set base href:
```html
<base href="/flutter_weather_app/">
```

#### Build
```bash
flutter build web --base-href "/flutter_weather_app/"
```

#### Deploy with GitHub Actions

Create `.github/workflows/deploy-web.yml`:
```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v4
      
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.24.0'
      
      - run: flutter pub get
      - run: flutter pub run build_runner build --delete-conflicting-outputs
      - run: flutter build web --release --base-href "/flutter_weather_app/"
      
      - name: Deploy to GitHub Pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./build/web
```

### 4. Netlify

1. Build web version:
```bash
flutter build web --release
```

2. Go to [Netlify](https://netlify.com)
3. Drag and drop `build/web` folder
4. Configure custom domain (optional)

### 5. Vercel

Install Vercel CLI:
```bash
npm install -g vercel
```

Deploy:
```bash
flutter build web --release
vercel --prod
```

## CI/CD Deployment

### GitHub Actions Automated Deployment

#### Android to Play Store

Create `.github/workflows/deploy-android.yml`:
```yaml
name: Deploy Android

on:
  push:
    tags:
      - 'v*'

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v4
      
      - uses: actions/setup-java@v4
        with:
          distribution: 'zulu'
          java-version: '17'
      
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.24.0'
      
      - run: flutter pub get
      - run: flutter pub run build_runner build --delete-conflicting-outputs
      
      - name: Build AAB
        run: flutter build appbundle --release
        env:
          KEY_STORE_PASSWORD: ${{ secrets.KEY_STORE_PASSWORD }}
          KEY_PASSWORD: ${{ secrets.KEY_PASSWORD }}
      
      - name: Upload to Play Store
        uses: r0adkll/upload-google-play@v1
        with:
          serviceAccountJsonPlainText: ${{ secrets.SERVICE_ACCOUNT_JSON }}
          packageName: com.example.weather_app
          releaseFiles: build/app/outputs/bundle/release/app-release.aab
          track: production
```

#### iOS to TestFlight

Create `.github/workflows/deploy-ios.yml`:
```yaml
name: Deploy iOS

on:
  push:
    tags:
      - 'v*'

jobs:
  deploy:
    runs-on: macos-latest
    
    steps:
      - uses: actions/checkout@v4
      
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.24.0'
      
      - run: flutter pub get
      - run: flutter pub run build_runner build --delete-conflicting-outputs
      
      - name: Build iOS
        run: flutter build ios --release --no-codesign
      
      # Configure fastlane for TestFlight upload
```

## Environment Configuration

### Production Environment

Create `.env.production`:
```
API_KEY=your_production_api_key
API_URL=https://api.openweathermap.org/data/2.5
```

### Staging Environment

Create `.env.staging`:
```
API_KEY=your_staging_api_key
API_URL=https://staging-api.example.com
```

## Version Management

### Semantic Versioning

Format: `MAJOR.MINOR.PATCH+BUILD`

```yaml
# pubspec.yaml
version: 1.2.3+45
```

- **MAJOR**: Breaking changes
- **MINOR**: New features (backward compatible)
- **PATCH**: Bug fixes
- **BUILD**: Build number (auto-increment)

### Creating Releases

```bash
# Create and push tag
git tag -a v1.2.3 -m "Release version 1.2.3"
git push origin v1.2.3
```

## App Store Optimization (ASO)

### Keywords

Choose relevant keywords:
- Weather app
- Weather forecast
- Live weather
- Current weather

### Screenshots

Prepare screenshots for all device sizes:
- Phone: 5.5", 6.5"
- Tablet: 12.9"

### Description

Write compelling app descriptions highlighting:
- Key features
- Benefits
- What makes it unique

## Post-Deployment Checklist

- [ ] Verify app functionality on production
- [ ] Test all features
- [ ] Check analytics integration
- [ ] Monitor crash reports
- [ ] Review user feedback
- [ ] Update documentation
- [ ] Announce release
- [ ] Monitor performance metrics

## Monitoring

### Crash Reporting

Integrate Firebase Crashlytics:
```dart
await FirebaseCrashlytics.instance.recordError(
  error,
  stackTrace,
  fatal: true,
);
```

### Analytics

Track user events:
```dart
await FirebaseAnalytics.instance.logEvent(
  name: 'weather_search',
  parameters: {'city': cityName},
);
```

## Rollback Strategy

If issues are found after deployment:

1. **Hot Fix**: Deploy patch version immediately
2. **Rollback**: Use store's rollback feature
3. **Communication**: Notify users of issues

## Resources

- [Flutter Deployment Documentation](https://flutter.dev/docs/deployment)
- [Google Play Console](https://play.google.com/console)
- [App Store Connect](https://appstoreconnect.apple.com)
- [Firebase Hosting](https://firebase.google.com/docs/hosting)
- [GitHub Pages](https://pages.github.com/)

## Support

For deployment issues:
- Check Flutter documentation
- Review platform-specific guides
- Search GitHub issues
- Contact support channels
