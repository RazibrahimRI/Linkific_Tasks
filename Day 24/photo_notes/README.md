## Day 24 — Flutter Optimization and Production: Performance, App Size, Best Practices and Release APK

## Overview

Day 24 focused on **optimizing a Flutter app and preparing it for production**: performance optimization, app size optimization, code organization, best practices, production setup, and building a signed release APK. A new app called **Photo Notes** (`photo_notes`) was built with two screens: a photo list loaded from the internet, and a notes screen with a local database.

## Learning Objectives

* Optimize app performance
* Reduce app size
* Follow Flutter best practices
* Prepare for production

## Topics Covered

### Performance Optimization

* **Const constructors** — used on all reusable widgets and fixed values. The `prefer_const_constructors` lint rule is turned on in `analysis_options.yaml`
* **Avoid unnecessary rebuilds** — each photo row is its own widget (`PhotoTile`), so only the changed part rebuilds
* **Long lists** — `ListView.builder` builds only the rows on screen
* **Image caching** — `CachedNetworkImage` keeps downloaded photos
* **Lazy loading** — a scroll listener loads the next 20 photos when the user is near the bottom

### App Size Optimization

* **Remove unused resources** — [files and packages removed, or "checked, none unused"]
* **Compress images** — app icon compressed with [tool name]
* **Vector graphics** — `assets/logo.svg` shown with `flutter_svg`
* **Split APKs by ABI** — `flutter build apk --release --split-per-abi`
* **Analyze the app bundle** — `flutter build apk --analyze-size --target-platform android-arm64`

### Code Organization

* **Folder structure** — files are grouped by type inside `lib/`: `constants`, `data`, `presentation`, `storage`, `theme`, `widgets`
* **Separate concerns** — `data/` talks to the internet or database, `presentation/` only draws screens
* **Reusable widgets** — `LoadingView` and `ErrorView` in `lib/widgets/`, used on both screens
* **Constants file** — `lib/constants/app_constants.dart`
* **Theme file** — `lib/theme/app_theme.dart`

### Best Practices

* **Null safety** — nullable types and default values in `Photo.fromJson`
* **Error handling** — try/catch on every network and database call, with a Retry view or a message
* **Loading states** — `LoadingView` on both screens and a spinner at the bottom of the list
* **Proper disposal** — `ScrollController` and `TextEditingController` are disposed
* **Accessibility labels** — `Semantics`, `tooltip`, `labelText` and `semanticsLabel`
* **Secure storage for secrets** — `flutter_secure_storage` (only a demo value is stored)
* **HTTPS only** — requests built with `Uri.https`, and no `usesCleartextTraffic` in the manifest
* **Input validation** — a note cannot be empty or longer than 100 characters
* **SQL injection prevention** — `sqflite` `insert` and `whereArgs` keep user text apart from the SQL command

### Prepare for Production

* **App icon** — `flutter_launcher_icons`
* **Splash screen** — `flutter_native_splash`
* **App name** — `android:label` in `AndroidManifest.xml`
* **Package name** — [your package name], set in `namespace` and `applicationId`
* **Version** — `1.0.0+1` in `pubspec.yaml`
* **Release build configuration** — signing config, code shrinking and resource shrinking in `android/app/build.gradle.kts`

### Build Release APK

* **Signing key** — created with `keytool` (`upload-keystore.jks`)
* **Configure signing** — `android/key.properties` and `signingConfigs` in `build.gradle.kts`
* **Build** — `flutter build apk --release --split-per-abi`
* **Test** — release APK installed and tested on an Android emulator

## Application Built

### photo_notes

## Packages Used

Each package is used for one listed item only.

| Package | Used for |
|---|---|
| `http` | Fetching the photo list over HTTPS |
| `cached_network_image` | Image caching |
| `flutter_svg` | Vector graphics (SVG) |
| `sqflite` and `path` | Local database, SQL injection prevention |
| `flutter_secure_storage` | Secure storage for secrets |
| `flutter_launcher_icons` (dev) | App icon |
| `flutter_native_splash` (dev) | Splash screen |

## Performance Improvements Documented

| Item | Before | After | How measured |
|---|---|---|---|
| Release APK (single) | 52.9 MB | 50.4 MB | `flutter build apk --release`, with shrinking off and then on |
| Release APK per device (arm64-v8a) | 50.4 MB | 17.6 MB | `--split-per-abi` |
| Icon image | [___ KB] | 35.2 KB | File properties |
| Material icons font | 1645184 bytes | 1784 bytes | Automatic icon tree-shaking in the release build |
| Photos loaded at start | All at once | 20 per page | Code (`AppConstants.pageSize`) |

**Split release APKs**

| ABI | Size |
|---|---|
| armeabi-v7a | 15.1 MB |
| arm64-v8a | 17.6 MB |
| x86_64 | 19.0 MB |

**Notes on the numbers**

* Code and resource shrinking saved about 2.5 MB (about 4.7%). This is small.
* Splitting by ABI is the main saving. An arm64 phone downloads 17.6 MB instead of 50.4 MB, about 65% smaller.
* Most of the APK size is the Flutter engine, which every Flutter app includes.
* Biggest parts from `--analyze-size`: [top items from the printed table].

## Concepts Learned

### Why split APKs by ABI

A single APK holds code for every phone type. A split APK holds code for one type only, so the download is smaller.

### Secure storage does not hide secrets in app code

A secret typed into a Dart file can always be extracted from the APK. Real secrets should come from a server. In this app only a demo value is stored, to show where a real secret would go.

### SQL injection prevention is shown by safe code

The app has no place where a user can type SQL into a raw query. The safe pattern (`insert`, `whereArgs`) is used, and the unsafe pattern is only noted in a code comment.

### Emulator is not a real device

The release APK was tested on an Android emulator with the x86_64 APK. No speed claims are made from the emulator.

## Important Issues Encountered

1. `No file or variants found for asset`: the SVG path in `pubspec.yaml` did not match the real file location. Fixed by using the same path in `pubspec.yaml`, the file location and the code.
2. `keytool` was not recognized in PowerShell. Fixed by running it with the full path of the `keytool` that comes with Android Studio.
3. `build.gradle.kts` errors on the `import` lines. The `import` lines must be the first lines of the file, and the keystore code must be outside the `plugins` block.
4. `null cannot be cast to non-null type kotlin.String`: `key.properties` was not being read. Fixed after checking its location (`android/`), its file name and its contents.
5. No physical Android device was available, so the release APK was tested on an emulator.
6. [ADD any other real problems]

## Current Verification Status

* **flutter analyze:** no issues found
* **Release build:** built successfully, signed, with split-per-abi
* **Emulator test:** [__ of 7] checks passed
* **Not done:** [e.g. tested on a real Android device, integration tests, Play Store publishing (not required by the task)]

**Emulator checks**

| Check | Result |
|---|---|
| Photos load and more load on scroll | [pass / fail] |
| Photos still show offline after loading (image cache) | [pass / fail] |
| Error message and Retry on first launch with no internet | [pass / fail] |
| Empty note shows a validation message | [pass / fail] |
| Note over 100 characters is rejected | [pass / fail] |
| Saved note is still there after reopening the app | [pass / fail] |
| Correct app name, icon and splash screen | [pass / fail] |

## Final Verification Checklist

### Learning Objectives
* [x] Optimize app performance
* [x] Reduce app size
* [x] Follow Flutter best practices
* [x] Prepare for production

### Watch
* [x] Optimization tutorials (2 hours)

### Performance Optimization
* [x] Use const constructors
* [x] Avoid unnecessary rebuilds
* [x] Use `ListView.builder` for long lists
* [x] Image caching
* [x] Lazy loading

### App Size Optimization
* [x] Remove unused resources
* [x] Compress images
* [x] Use vector graphics (SVG)
* [x] Split APKs by ABI
* [x] Analyze app bundle

### Code Organization
* [x] Feature-based folder structure (files are grouped by type, not by feature)
* [x] Separate concerns
* [x] Reusable widgets
* [x] Constants file
* [x] Theme file

### Best Practices
* [x] Null safety
* [x] Error handling everywhere
* [x] Loading states
* [x] Proper disposal
* [x] Accessibility labels
* [x] Secure storage for secrets
* [x] HTTPS only
* [x] Input validation
* [x] SQL injection prevention

### Prepare for Production
* [x] App icons
* [x] Splash screen
* [x] App name
* [x] Package name
* [x] Version numbers
* [x] Release build configuration

### Build Release APK
* [x] Generate signing key
* [x] Configure signing
* [x] Build release APK
* [x] Test release build

### Deliverables
* [x] Optimized Flutter app — `photo_notes`
* [x] Release APK generated — `build/app/outputs/flutter-apk/`
* [x] Performance improvements documented
* [x] Best practices checklist
* [x] README with optimization guide

## Optimization Guide

### Setup

```bash
flutter pub get
```

### Check code

```bash
flutter analyze
```

### Run the app

```bash
flutter run
```

### Configure icons and splash screen

```bash
dart run flutter_launcher_icons
dart run flutter_native_splash:create
```

### Generate a signing key (Windows)

```powershell
& "C:\Program Files\Android\Android Studio\jbr\bin\keytool.exe" -genkey -v -keystore $env:USERPROFILE\upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

Then create `android/key.properties` with `storePassword`, `keyPassword`, `keyAlias` and `storeFile`, and add `android/key.properties` and `*.jks` to `.gitignore`. Never commit the keystore or its passwords.

### Build the release APK

```bash
flutter build apk --release
flutter build apk --release --split-per-abi
```

The APKs are in `build/app/outputs/flutter-apk/`.

### Analyze the app size

```bash
flutter build apk --analyze-size --target-platform android-arm64
```

### Install on an emulator

```bash
adb install build/app/outputs/flutter-apk/app-x86_64-release.apk
```

### Optimization tips

* Use `const` on every widget whose values never change
* Put each list row in its own small widget
* Use `ListView.builder` for long lists, never a `Column` of all items
* Load data in pages instead of all at once
* Always dispose controllers
* Keep the signing key and `key.properties` out of Git
* Write only measured numbers in the documentation

## Repository Structure

```text
photo_notes/
│
├── android/
│   ├── key.properties        (not in Git)
│   └── app/build.gradle.kts
├── assets/
│   ├── icon.png
│   └── logo.svg
├── lib/
│   ├── main.dart
│   ├── home_screen.dart
│   ├── constants/app_constants.dart
│   ├── theme/app_theme.dart
│   ├── storage/secure_store.dart
│   ├── widgets/
│   │   ├── loading_view.dart
│   │   └── error_view.dart
│   ├── data/
│   │   ├── photo.dart
│   │   ├── photo_service.dart
│   │   └── notes_database.dart
│   └── presentation/
│       ├── photos_screen.dart
│       ├── photo_tile.dart
│       └── notes_screen.dart
├── test/
├── docs/screenshots/
├── pubspec.yaml
└── README.md
```

## Screenshots

<img width="345" height="744" alt="image" src="https://github.com/user-attachments/assets/46f3a1b8-2cad-4d0f-a672-9b0d6e599cf4" />
<img width="336" height="750" alt="image" src="https://github.com/user-attachments/assets/d06eda73-a9df-4210-955d-e8239f361ace" />
<img width="349" height="756" alt="image" src="https://github.com/user-attachments/assets/248e4b26-efcd-4236-9b3f-2537fbd20c28" />


## Resources

* https://docs.flutter.dev/perf/best-practices
* https://docs.flutter.dev/perf/app-size
* https://docs.flutter.dev/deployment/android

## Conclusion

Day 24 covered performance optimization, app size reduction, code organization, best practices, production setup and a signed release APK. The main lessons were that the signing setup is sensitive to where code and files are placed, that splitting APKs by ABI saved far more than code shrinking (50.4 MB down to 17.6 MB per device against 2.5 MB saved), and that an emulator test is not a real device test.
