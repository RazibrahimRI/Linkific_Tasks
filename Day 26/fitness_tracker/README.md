## Day 26 — Flutter Application Implementation: Fitness Tracker

## Overview

Day 26 was the **implementation phase** of the Fitness Tracker (`fitness_tracker`) planned on Day 25. The app was built **individually**, using the project, backend, state management, packages, screens, folder structure and database schema chosen in the planning task. Nothing outside the Day 26 task was added.

The work followed the task in three parts: authentication, core UI and backend setup.

## Learning Objectives

* Implement authentication
* Build core features
* Setup backend
* Create main screens

## Topics Covered

### Implement Authentication

* **Login/register screens** — `login_screen.dart` and `signup_screen.dart`, with error messages from Firebase shown in a message bar and a loading state on the button
* **Firebase auth** — Firebase Authentication with Email/Password, handled in `auth_service.dart` and `auth_provider.dart`. A `users/{userId}` document is created at sign-up
* **Splash screen** — `splash_screen.dart` is shown while the app checks the saved login state
* **Protected routes** — `AuthGate` in `main.dart` shows the Splash screen, then the Login screen for a logged-out user or the 5-tab app for a logged-in user. All app screens sit under this gate

### Build Core UI

* **Navigation structure** — a bottom bar with 5 tabs (Workouts, Charts, Goals, Water, BMI) in `main_bottom_nav.dart`, a Logout button in the top bar, and the Add/Edit Workout screen opened from the Workout List
* **Main screens layout** — Workout List, Add/Edit Workout, Progress Charts, Goals, Water Tracker and BMI Calculator, plus Login and Sign Up
* **Reusable components** — `AppTextField`, `AppButton` (with loading state) and `ProgressBlock` (label with progress bar, used by Goals and Water), in `lib/widgets/`
* **Theme implementation** — `lib/theme/app_theme.dart` sets the colors, app bar, input fields and buttons once for the whole app

### Setup Backend

* **Database schema** — Cloud Firestore, as defined in Day 25:
  * `users/{userId}`: email, createdAt
  * `users/{userId}/workouts`: name, durationMinutes, date
  * `users/{userId}/goals/current`: weeklyWorkoutMinutes, dailyWaterMl
  * `users/{userId}/waterLogs`: amountMl, date
* **API endpoints** — not needed. The app calls Firebase Authentication and Cloud Firestore directly through their SDKs, so no server or endpoints were created
* **Real-time listeners** — Firestore `snapshots()` streams for workouts, goals and today's water entries, connected to the screens through Provider
* **File storage** — not required. No screen or collection in the schema stores files, and `firebase_storage` is not in the 5 selected packages

## Application Implemented

### fitness_tracker

A Flutter app with a Firebase backend where a user signs up, logs in, logs workouts (add, edit, delete), sees a 7-day progress chart, sets goals, tracks daily water intake and calculates BMI. Each user sees only their own data, and data is saved in Cloud Firestore.

## Packages Used

No new packages were added on Day 26.

| Package | Used for |
|---|---|
| `firebase_core` | Connecting the app to Firebase |
| `firebase_auth` | User authentication |
| `cloud_firestore` | Saving and listening to workouts, water entries and goals |
| `provider` | State management |
| `fl_chart` | Progress charts |

## Concepts Learned

### Auth state decides which screen is shown

One `AuthGate` listens to the login state. It shows the Splash screen until Firebase reports the state, so the app never flashes the wrong screen. Because every app screen sits under the gate, logged-out users cannot reach them.

### Service, provider and screen each have one job

The service talks to Firebase, the provider holds the data and notifies the screens, and the screen only shows it. A Firestore stream in the provider updates the screen automatically when data changes.

### Reusable components keep screens consistent

One text field, one button and one progress block are used on several screens, so a change is made in one place.

### Theme sets the style once

Colors and the style of buttons and input fields come from `app_theme.dart`. Because the theme makes buttons full width, a button placed next to a field in a `Row` needs its own layout handling, so the Water screen places the button below the field.

### A new provider needs a full restart

Hot reload does not pick up a provider added in `main.dart`. The app must be fully restarted.

## Important Issues Encountered

1. `ProviderNotFoundError` for `GoalProvider` on the Goals screen — the provider was added to `main.dart` while the app was running. Fixed with a full restart.
2. Compile errors after replacing the plain `TextField` and `ElevatedButton` with `AppTextField` and `AppButton` — the old parameters (`decoration`, `obscureText`, `child`) were kept. Fixed by using `label`, `obscure` and `text`.
3. Login screen stuck on top after signing in from the Sign Up screen — the "Have an account? Login" link pushed a new Login screen onto the stack. Fixed by using `Navigator.pop`.

## Known Limits

* Progress charts and the weekly goal use the **last 7 days**, not the calendar week
* Water entries can be added but not deleted
* There is no offline handling

## Current Verification Status

* **Authentication:** sign up, login, logout, and returning to the app after closing it were tested by running the app
* **Core UI:** all screens, the 5-tab navigation and the theme were checked by running the app
* **Backend:** workouts, goals and water entries appear in Cloud Firestore, are still there after restarting the app, and update live in the app
* **Security rules:** published on the Cloud Firestore Rules page. A second account sees none of the first account's workouts, goals or water
* **Not done:** features and tasks outside Day 26 were not built. CI/CD, deployment and store publishing are not part of the task

## Final Verification Checklist

### Learning Objectives
* [x] Implement authentication
* [x] Build core features
* [x] Setup backend
* [x] Create main screens

### Authentication
* [x] Login screen
* [x] Register screen
* [x] Firebase/Supabase auth (Firebase Authentication)
* [x] Splash screen
* [x] Protected routes

### Core UI
* [x] Navigation structure
* [x] Main screens layout
* [x] Reusable components
* [x] Theme implementation

### Backend
* [x] Database schema
* [x] API endpoints (if needed) — not needed, Firebase SDKs are used directly
* [x] Real-time listeners
* [x] File storage — not required, no file data in the schema

## Setup Guide

### Get the packages

```bash
flutter pub get
```

### Check the code

```bash
flutter analyze
```

### Run the app

```bash
flutter run
```

### Firestore security rules

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId}/{document=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

Publish these on the **Cloud Firestore** Rules page, not the Realtime Database page.

### Git workflow

```bash
git checkout main
git pull
git checkout -b feature/day26-implementation
git add "Day 26/fitness_tracker"
git commit -m "Day 26: authentication, core UI and backend"
git push -u origin feature/day26-implementation
```

Then open a pull request on GitHub and merge it. Always add only the `Day 26/fitness_tracker` folder, never `git add .`.

## Repository Structure

```text
fitness_tracker/
│
├── android/
├── ios/
├── docs/
│   ├── proposal.md
│   ├── architecture.md
│   ├── task-breakdown.md
│   ├── team-roles.md
│   ├── wireframes/
│   └── screenshots/
├── lib/
│   ├── main.dart
│   ├── firebase_options.dart
│   ├── models/
│   │   ├── workout.dart
│   │   ├── water_log.dart
│   │   └── goal.dart
│   ├── services/
│   │   ├── auth_service.dart
│   │   └── firestore_service.dart
│   ├── providers/
│   │   ├── auth_provider.dart
│   │   ├── workout_provider.dart
│   │   ├── water_provider.dart
│   │   └── goal_provider.dart
│   ├── screens/
│   │   ├── splash_screen.dart
│   │   ├── login_screen.dart
│   │   ├── signup_screen.dart
│   │   ├── workout_list_screen.dart
│   │   ├── add_edit_workout_screen.dart
│   │   ├── progress_charts_screen.dart
│   │   ├── goals_screen.dart
│   │   ├── water_tracker_screen.dart
│   │   └── bmi_calculator_screen.dart
│   ├── theme/
│   │   └── app_theme.dart
│   └── widgets/
│       ├── main_bottom_nav.dart
│       ├── app_text_field.dart
│       ├── app_button.dart
│       └── progress_block.dart
├── firebase.json
├── pubspec.yaml
└── README.md
```

## Screenshots

| | | |
|---|---|---|
| <img width="342" height="719" alt="Screenshot 2026-10-05 185828" src="https://github.com/user-attachments/assets/c694fbc7-4805-4c37-b363-809319a6117d" />Sign Up |<img width="346" height="758" alt="Screenshot 2026-10-05 185426" src="https://github.com/user-attachments/assets/73aefb14-b9fa-4689-8519-d340f4bec8be" /> Progress Charts | <img width="346" height="741" alt="Screenshot 2026-10-05 185432" src="https://github.com/user-attachments/assets/0e53ca90-0e04-4db3-8616-579019e3d75f" />Goals |
| <img width="348" height="761" alt="Screenshot 2026-10-05 185438" src="https://github.com/user-attachments/assets/46c707f8-67a6-4312-b0d5-2bb1f4ac1077" />Water Tracker | <img width="336" height="742" alt="Screenshot 2026-10-05 185740" src="https://github.com/user-attachments/assets/bc371470-c4b0-4444-a39e-804984248fc6" />BMI Calculator | |

## Resources

* https://docs.flutter.dev
* https://firebase.google.com/docs/flutter/setup
* https://firebase.google.com/docs/firestore/security/get-started
* https://pub.dev/packages/provider
* https://pub.dev/packages/fl_chart

## Conclusion

Day 26 covered implementing authentication with Firebase, building the core UI with navigation, reusable components and a theme, and setting up the Cloud Firestore backend with the planned schema and real-time listeners. API endpoints and file storage were checked against the project's needs and not created, because the app does not require them. The main lessons were that one auth gate protects every screen, that Provider screens update automatically from Firestore streams, and that a newly added provider needs a full restart.
