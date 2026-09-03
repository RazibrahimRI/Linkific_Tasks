# Linkific_Tasks
# Day 1 – Android Studio Setup & Flutter Installation

## What I did
- Verified Flutter SDK installation (Flutter 3.27.2, stable channel)
- Ran `flutter doctor` and fixed the Android licenses issue (`flutter doctor --android-licenses`)
- Confirmed Android Studio (2022.3) and VS Code setup for Flutter development
- Set up and tested an Android emulator (Pixel 7 API 34)
- Created a new Flutter project: `flutter create first_app`
- Ran the app on the emulator, tested hot reload and hot restart
- Explored the project structure: `lib/main.dart`, `pubspec.yaml`, `android/` and `ios/` folders

## Issue faced
Hit an "Error waiting for a debug connection: log reader stopped unexpectedly" error when running the app on the emulator. Resolved by fully cold-booting the emulator and confirming the ADB connection (`adb devices`) before running `flutter run`.

## Flutter CLI commands used
- `flutter create first_app`
- `flutter run`
- `flutter doctor`
- `flutter clean`
- `adb devices`

## Project location
See `Day 1/first_app` for the working project.
