# Day 16 - Flutter Firebase Authentication

## Overview

Day 16 focused on implementing **Firebase Authentication** in Flutter — email/password sign-up and sign-in, Google Sign-In, auth state management via a stream, and a basic user profile screen. The task went through two project attempts: an initial app named `firebase_auth`, and a clean rebuild named `flutter_firebase_practice` after the first project accumulated environment-level issues (see below). `firebase_core`, `firebase_auth`, and `google_sign_in` were used, backed by a Firebase project (`flutter-auth-internship`) configured via the FlutterFire CLI.

## Learning Objectives

* Setup Firebase in Flutter
* Implement Firebase Auth
* Email/password authentication
* Social authentication (Google)

## Topics Covered

### Firebase Project Setup

* Creating a Firebase project and registering an Android app
* Downloading and placing `google-services.json`
* Using the FlutterFire CLI (`flutterfire configure`) instead of manual Gradle editing, to auto-generate `firebase_options.dart` and wire up the Google services Gradle plugin
* Platform selection during `flutterfire configure` — must be scoped to Android only; selecting all available platforms (ios, macos, web, windows) registers unnecessary Firebase apps and pulls in unrelated SDK downloads on every build

### Firebase Initialization

* `Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)` inside an async `main()`, called before `runApp()`
* Confirming successful init via a working app launch, since a hang here blocks the first frame from ever rendering

### Email/Password Authentication

* `createUserWithEmailAndPassword()` for registration
* `signInWithEmailAndPassword()` for login
* `signOut()`
* Exception handling via `FirebaseAuthException` (`e.message`)

### Google Sign-In

* The `google_sign_in` package's v7 API differs significantly from the older `.signIn()` method shown in most existing tutorials: `GoogleSignIn.instance.initialize()` followed by `.authenticate()`, then building a Firebase credential from the returned `idToken`
* Web OAuth Client ID (`serverClientId`) required even for an Android-only app, since Firebase uses it to verify tokens
* SHA-1 fingerprint registration in Firebase Console, obtained via `./gradlew signingReport`

### Auth State Management

* `authStateChanges()` stream exposed as a getter on a custom `AuthService` class
* `StreamBuilder<User?>` in an `AuthGate` widget to route between `LoginScreen` and `ProfileScreen` automatically, based on stream state — no manual navigation calls needed

## Application Built

### `flutter_firebase_practice`
(rebuilt from an earlier attempt named `firebase_auth`)

## Features

* Email/password registration and login, with Firebase-provided error messages surfaced in the UI
* Google Sign-In using the current `google_sign_in` v7 API, linked to Firebase via `signInWithCredential`
* Centralized `AuthService` class separating auth logic from UI
* `AuthGate` widget using `authStateChanges` to auto-route between Login and Profile screens
* Profile screen displaying the signed-in user's email and UID
* Sign-out clears session and auto-routes back to Login via the same stream

## Concepts Learned

### FlutterFire CLI replaces manual Gradle setup — but only if you let it

The Firebase Console's manual setup wizard (adding the Google services Gradle plugin by hand to `build.gradle.kts`) duplicates what `flutterfire configure` already automates. Running both is redundant and risks conflicting plugin entries. Pick one path — the CLI is the simpler approach for an app at this stage.

### Selecting extra platforms in `flutterfire configure` has real cost, not just clutter

Selecting ios/macos/web/windows alongside android during configuration registered four unnecessary Firebase apps in the console and caused `flutter run` to download the Web and Windows engine SDKs on every clean build — SDKs the Android-only app never uses. Platform selection should match the task scope exactly.

### A Flutter project cannot share its own name with one of its dependencies

Naming a project `firebase_auth` and then adding the `firebase_auth` package as a dependency produces `A package may not list itself as a dependency` — not a real circular dependency, but a naming collision Dart's package resolver can't distinguish. This was the direct cause of the decision to rename the project (and eventually rebuild it cleanly as `flutter_firebase_practice`).

### A stuck splash screen with no visible error usually means `main()` never finished

If `Firebase.initializeApp()` hangs or throws before `runApp()` executes, Flutter never draws its first frame — the native splash screen (or a bare Flutter logo) stays on screen indefinitely with no red error screen, since Flutter's own error UI hasn't loaded yet either. Diagnosing this required checking the Run console (not just Logcat, which only shows Android-level renderer noise) and testing whether hot reload (`r`) still responded, to determine if the Dart isolate was alive at all.

### Duplicate config files and stale `firebase.json` silently break FlutterFire CLI

A leftover `google-services (1).json` in `android/app/` (from copying between project attempts) created ambiguity for the Gradle plugin. Separately, a stale `firebase.json` carried over from the first project attempt caused `flutterfire configure` to try reusing an old iOS app registration and fail outright with a Firebase CLI error, before even reaching the Android configuration step. Both were resolved by deleting the leftover files and reconfiguring fresh.

### "Entrypoint doesn't contain a main function" can be a red herring

This error didn't mean `main()` was missing — it meant a *different* compile error elsewhere in `main.dart` was fatal enough that the IDE misreported the entrypoint itself as invalid. The real causes were: `runApp(const MyApp())` referencing a `MyApp` class that was never defined in the file, and an `AuthGate` class being both imported from `auth_gate.dart` and redefined inline in `main.dart`, causing a duplicate-definition conflict. Splitting `AuthGate` into its own file and defining `MyApp` properly in `main.dart` resolved it.

### The Kotlin Gradle Plugin (KGP) warning is not an error

`firebase_auth` and `firebase_core` currently trigger a warning about applying KGP directly rather than using Flutter's Built-in Kotlin support. This is forward-looking (a future Flutter version will require plugin updates) and did not block any build in this task — it can be safely ignored for now.

## Important Issues Encountered

**Multiple environment-level issues compounded during setup, ultimately requiring a clean project rebuild.**

Root causes, in the order they surfaced:
1. Selecting all platforms instead of Android-only during `flutterfire configure`
2. Project named `firebase_auth`, colliding with the `firebase_auth` package dependency
3. Missing `authStateChanges` getter on `AuthService`, referenced in `main.dart` before being defined
4. Duplicate `google-services (1).json` in `android/app/`
5. Stale `firebase.json` from the first project attempt breaking `flutterfire configure` on the rebuilt project
6. `main.dart` referencing an undefined `MyApp` class, and `AuthGate` defined twice (once inline, once imported)

Resolution: rather than continuing to patch the first project (`firebase_auth`), a fresh project (`flutter_firebase_practice`) was created to eliminate the naming collision and stale config files at the source, with only the author's own code files (`auth_service.dart`, `login_screen.dart`, `register_screen.dart`, `profile_screen.dart`, `auth_gate.dart`) carried over — not the generated config files (`google-services.json`, `firebase_options.dart`, `firebase.json`), which were regenerated fresh for the new project name and package ID.

## Current Verification Status

The `main.dart` compile errors (missing `MyApp`, duplicate `AuthGate`) were diagnosed and corrected, and `flutterfire configure` was successfully re-run against the clean project after removing the stale `firebase.json`. **A successful end-to-end run confirming the app launches past the splash screen to the Login screen has not yet been observed in this session** — confirm the checklist below before treating Day 16 as complete.

## Final Verification Checklist

* [ ] `flutter clean && flutter pub get && flutter run` completes with no compile errors
* [ ] App launches past the Flutter splash logo to the Login screen (not stuck)
* [ ] Register a new account with email/password → navigates back to Login
* [ ] Log in with that account → `AuthGate` auto-routes to Profile screen (no manual navigation)
* [ ] Profile screen displays the correct email and UID
* [ ] Sign out → auto-routes back to Login screen
* [ ] Sign in with Google → same auto-route to Profile screen, correct Google account email shown
* [ ] Firebase Console → Authentication → Users tab shows both the email/password and Google accounts created during testing
* [ ] Only one Firebase Android app is registered under `flutter-auth-internship` (no leftover ios/macos/web/windows apps from earlier platform over-selection)
* [ ] `android/app/` contains exactly one `google-services.json`, no duplicates

## Repository Structure

```text
Day 16/
│
├── flutter_firebase_practice/
│   ├── lib/
│   │   ├── main.dart
│   │   ├── auth_service.dart
│   │   ├── auth_gate.dart
│   │   ├── login_screen.dart
│   │   ├── register_screen.dart
│   │   ├── profile_screen.dart
│   │   └── firebase_options.dart
│   ├── android/
│   │   └── app/
│   │       └── google-services.json
│   ├── pubspec.yaml
│   └── README.md
└── README.md
```

## Screenshots

> _Add screenshots here once the verification checklist above is completed._

| Screen | Screenshot |
|---|---|
| Login screen | <img width="340" height="744" alt="image" src="https://github.com/user-attachments/assets/49d37f26-dc8f-4962-b19f-4c79643caa71" />
 |
| Register screen | <img width="333" height="746" alt="image" src="https://github.com/user-attachments/assets/7a9cd4d0-8cfb-4214-b94e-734f84457955" />
|
| Profile screen (email/password login) | <img width="335" height="740" alt="image" src="https://github.com/user-attachments/assets/8423c7f9-67c7-4a94-94fd-3e2b20dc2e07" />
 |
| Profile screen (Google sign-in) | <img width="344" height="755" alt="image" src="https://github.com/user-attachments/assets/e995f2f3-e7aa-40bb-95cc-3118f30f4a06" />
 |
| Firebase Console — Authentication → Users | <img width="1912" height="896" alt="image" src="https://github.com/user-attachments/assets/a93b3cf1-c907-4e3b-b730-0cf83d0fa455" />
 |

## Resources

FlutterFire Documentation:
https://firebase.google.com/docs/flutter/setup

google_sign_in Package (v7 API):
https://pub.dev/packages/google_sign_in

firebase_auth Package:
https://pub.dev/packages/firebase_auth

## YouTube Search Terms

* Firebase Flutter setup
* Firebase authentication Flutter
* Google sign in Flutter
* Flutter Firebase complete tutorial

## Recommended Channels

* The Flutter Way
* Reso Coder
* Flutter Explained

## Conclusion

Day 16 covered Firebase Authentication end-to-end — email/password auth, Google Sign-In, and stream-based auth state routing. Unlike Day 15, the core blockers here weren't API/backend limitations but environment and project-configuration issues: platform over-selection during FlutterFire setup, a project name colliding with its own dependency, stale config files carried across project attempts, and class-definition conflicts in `main.dart`. None of these were Firebase or Flutter bugs — all were traceable to specific, fixable mistakes in setup and file management, which is itself the main lesson: a stuck splash screen or a misleading compile error is almost always downstream of a small, findable cause, not a framework-level failure. Final end-to-end verification against the checklist above is still pending.
