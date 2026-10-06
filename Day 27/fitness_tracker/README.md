## Day 27 — Flutter Application: Core Features and Integration (Fitness Tracker)

## Overview

Day 27 continued the Fitness Tracker (`fitness_tracker`) from Day 26. The app was completed **individually**, using the same project, Firebase backend, Provider state management, 5 packages, screens, folder structure, theme, reusable components and database schema as before. Nothing outside the Day 27 task was added.

The work followed the task in two parts: core features and integration, and team collaboration.

## Learning Objectives

* Implement CRUD operations
* Implement state management
* Integrate APIs
* Implement data persistence
* Build user interactions (forms, buttons, navigation, loading states)
* Complete team collaboration (code reviews, merging, conflicts, integration)

## Topics Covered

### CRUD Operations

* **Workouts** — Create, Read, Update and Delete are all in `firestore_service.dart` (`addWorkout`, `workoutsStream`, `updateWorkout`, `deleteWorkout`) and used from `add_edit_workout_screen.dart`
* **Water logs** — Create and Read already existed. **Delete was added** (`deleteWaterLog` in `firestore_service.dart`, `delete` in `water_provider.dart`, a delete icon on each log in `water_tracker_screen.dart`)
* **Goals** — one document (`goals/current`) that is read and saved. Delete is not needed for a single goal document
* All operations use Cloud Firestore and match the Day 25 schema. No new collections or fields were added

### State Management

* Provider is used, as selected on Day 25
* `WorkoutProvider` and `WaterProvider` listen to Firestore streams. Lists, totals and charts update by themselves after a create, update or delete
* An `isLoading` flag was added to `WorkoutProvider` and `WaterProvider`. It is `true` until the first data arrives

### API Integration

* **Not required.** The app calls Firebase Authentication and Cloud Firestore directly through their SDKs. The project requirements define no external API, so none was added

### Data Persistence

* All data is saved in Cloud Firestore under `users/{userId}/...`
* Data is still there after closing and reopening the app, and after logging out and in again

### User Interactions

* **Forms with validation** — the Add/Edit Workout screen uses a `Form` with field validators (name must not be empty, minutes must be a number greater than 0). The Water screen checks the amount before saving. Invalid input shows an error and nothing is saved
* **Button actions** — Save (add or update a workout), Delete (workout and water log), Add (water), and the + button to open the Add Workout screen
* **Navigation flows** — Splash, then Login or Sign Up, then the 5-tab app. Workout List opens Add/Edit Workout (from + or by tapping a workout) and returns after Save or Delete. Logout returns to Login
* **Loading states** — a spinner while the workout list and water list load, and while a workout is being saved or deleted. The Save button and the water Add button show a loading state

### Team Collaboration

* **Code reviews** — the project was done individually, so the code was reviewed through a pull request on GitHub, reading the "Files changed" tab before merging
* **Merge branches** — Day 26 branch merged first, then `feature/day27-core-features` merged into `main`
* **Resolve conflicts** — no conflicts occurred
* **Integration** — the merged `main` branch was run and the full flow was tested

## Application Implemented

### fitness_tracker

A Flutter app with a Firebase backend where a user signs up, logs in, logs workouts (add, edit, delete), sees a 7-day progress chart, sets goals, tracks daily water intake (add and delete) and calculates BMI. Each user sees only their own data, and data is saved in Cloud Firestore.

## Packages Used

No new packages were added on Day 27.

| Package | Used for |
|---|---|
| `firebase_core` | Connecting the app to Firebase |
| `firebase_auth` | User authentication |
| `cloud_firestore` | Saving, updating, deleting and listening to data |
| `provider` | State management |
| `fl_chart` | Progress charts |

## Concepts Learned

### Real-time streams keep the screen in sync

Because the providers listen to Firestore `snapshots()`, an add, edit or delete changes the list, the totals and the chart without a manual refresh. The provider methods only call the service.

### One service, one provider, one screen

The service talks to Firebase, the provider holds the data and the loading flag, and the screen only shows it. Adding water delete meant one method in each layer.

### Form validation

A `Form` with a `GlobalKey` and `validator` functions checks every field at once with `validate()`, and shows an error under the field that is wrong.

### Loading states

A loading flag in the provider covers the first load. A local `_saving` flag in the screen covers a single save or delete and stops a double tap.

## Important Issues Encountered

1. `isLoading` error on the Water screen — the screen used `water.isLoading`, but the field had not been added to `WaterProvider`. Fixed by adding the field and updating `setUser`.
2. Duplicate imports and an unused edit dialog in `workout_list_screen.dart` — the Add/Edit screen already handled editing, so the extra dialog was removed instead of keeping a duplicate feature.
3. Emulator error "Running multiple emulators with the same AVD" — the emulator was already running. Fixed by ending the stuck emulator process and starting it once from Device Manager.

## Known Limits

* Progress charts and the weekly goal use the **last 7 days**, not the calendar week
* The water list shows **today's** entries only
* There is no offline handling

## Current Verification Status

* **Water:** the list shows a spinner then the data, invalid amounts are rejected, an entry is added and appears in Cloud Firestore, and deleting it removes it from the list, the console and the total
* **Workouts:** the list shows a spinner then the data, empty name and invalid minutes are rejected, a valid workout is saved with a loading state, editing keeps the date, and deleting removes it from the list, the console and the chart
* **Charts:** update after an add, edit or delete without a manual refresh
* **Persistence:** data is still there after fully closing and reopening the app
* **Isolation:** a second account sees none of the first account's data
* **Navigation:** splash, login, every tab and logout were walked through
* **Not done:** features and tasks outside Day 27 were not built. Analytics, testing tasks, CI/CD, deployment and store publishing are not part of the task

## Final Verification Checklist

### Core Implementation
* [x] CRUD operations
* [x] State management
* [x] API integration — not required, Firebase SDKs are used directly
* [x] Data persistence

### User Interactions
* [x] Forms with validation
* [x] Button actions
* [x] Navigation flows
* [x] Loading states

### Deliverables
* [x] Authentication working
* [x] Main screens built
* [x] Backend integrated
* [x] Core features functional
* [x] Code reviewed

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
git checkout -b feature/day27-core-features
git add "Day 27/fitness_tracker"
git status
git commit -m "Day 27: CRUD, state updates, forms and loading states"
git push -u origin feature/day27-core-features
```

Then open a pull request on GitHub, review the changed files, and merge it. Always add only the `Day 27/fitness_tracker` folder, never `git add .`.

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
| Add Workout (validation error) | Workout List | Edit Workout |
| Water Tracker (with delete) | Progress Charts | Cloud Firestore console |

## Resources

* https://docs.flutter.dev
* https://firebase.google.com/docs/flutter/setup
* https://firebase.google.com/docs/firestore/security/get-started
* https://pub.dev/packages/provider
* https://pub.dev/packages/fl_chart

## Conclusion

Day 27 completed the core features of the Fitness Tracker: full CRUD for workouts and water logs on Cloud Firestore, Provider state that updates the screens and charts live, validated forms, working buttons and navigation, and loading states on lists and on save and delete. No external API was needed. The main lessons were that a stream-based provider keeps every screen in sync with little code, that validation belongs in the form, and that a local saving flag prevents double submits.
