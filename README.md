# new_pdd_demo 🚀

A Flutter demo app with a modular architecture, authentication flow, user info features, network handling, and dependency injection.

## ✨ Highlights

- **Modular structure** for clean separation of core services and feature logic
- **Authentication + user info** features built into the demo app
- **Network, storage, routing, theming, and DI** organized in `lib/core/`
- Ready for both **Android** and **iOS** development

## 🧠 Overview

This repository contains a Flutter application designed to be easy to explore and extend. The main code areas are:

- `lib/main.dart` - App entry point
- `lib/core/` - Shared infrastructure like network, storage, error handling, routing, theme, and dependency injection
- `lib/feature/` - Feature modules such as `auth` and `user_info`
- `lib/generated/` - Generated assets and code

## 🚀 Quick Start

1. Install Flutter: https://docs.flutter.dev/get-started/install
2. Install FVM: https://fvm.app/docs/getting_started
3. Open a terminal in the project root:

```bash
cd /Users/salmansmacbookpro/Documents/Developer/my_project_demo/new_pdd_demo
fvm install
fvm flutter pub get
```

4. Run the app on a connected device or emulator:

```bash
fvm flutter run
```

## 🧾 Environment

- Flutter version: `3.41.2` (via `.fvmrc`)
- Dart SDK: `^3.11.0`
- FVM config file: `.fvmrc`

## 🧪 Build & Test

- Build Android APK:

```bash
flutter build apk
```

- Build iOS app:

```bash
flutter build ios
```

- Run tests:

```bash
flutter test
```

## 📁 Project Structure

- `android/` - Android platform-specific sources and Gradle configuration
- `ios/` - iOS platform-specific sources and Xcode workspace
- `lib/` - Main Flutter app code
- `test/` - Automated unit and widget tests

## 💡 Notes

This README has been refreshed with icons and helpful sections to make the project easier to explore. Update the feature descriptions as your app evolves.
