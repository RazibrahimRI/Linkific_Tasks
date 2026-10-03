## Day 25 — Flutter Application Planning and Setup: Fitness Tracker

## Overview

Day 25 focused on **planning and setting up a complete Flutter application**: choosing a project, defining requirements, designing the architecture, creating wireframes, setting up the project, and defining how the work is managed. The **Fitness Tracker** (`fitness_tracker`) was selected and completed **individually**, as instructed by the mentor.

This day was **planning and setup only**. The app features are not built yet.

## Learning Objectives

* Plan complete Flutter application
* Design architecture
* Create wireframes
* Setup project

## Topics Covered

### Form Teams

* **Team size** — the task asks for teams of 2–3 interns. The mentor replied "Complete it individually", so the work was done alone
* **Roles** — planner, developer and reviewer are all held by one person, see `docs/team-roles.md`

### Brainstorm Project Ideas

* **Options reviewed** — Social Media App, E-commerce App, Chat Application, Fitness Tracker
* **Selected** — D. Fitness Tracker, with only its 7 listed features: workout logging, progress charts, goal setting, BMI calculator, water intake tracker, user authentication and data persistence
* **Reason** — lowest technical risk for one person; no real-time sync, push notifications or payments needed

### Define Requirements

* **Features** — the 7 features above
* **User flows** — 9 flows (sign up, login, log a workout, edit or delete a workout, view progress, set goals, track water, check BMI, log out)
* **Screens needed** — 8 screens: Login, Sign Up, Workout List, Add/Edit Workout, Progress Charts, Goals, Water Tracker, BMI Calculator
* **API requirements** — Firebase Authentication calls and Cloud Firestore calls for the logged-in user only
* **Database schema** — `users`, `users/{userId}/workouts`, `users/{userId}/waterLogs`, `users/{userId}/goals`
* Full details are in `docs/proposal.md`

### Design Architecture

* **State management** — Provider
* **Backend** — Firebase (Authentication and Cloud Firestore)
* **Packages** — the 5 packages in the table below
* **Folder structure** — files grouped by type inside `lib/`
* Full details are in `docs/architecture.md`

### Create Wireframes

* **Sketch all screens** — 8 wireframe images in `docs/wireframes/`
* **Navigation flow** — app checks login, then opens the Workout List or the Login screen; a bottom bar with 5 tabs switches between Workouts, Charts, Goals, Water and BMI
* **UI components** — text fields, buttons, top bar with Logout, bottom navigation bar, lists, floating add button, date picker, bar chart, progress bars, result text, loading indicator and error message
* Full details are in `docs/wireframes/wireframes.md`

### Setup Project

* **Initialize Flutter project** — `flutter create fitness_tracker`
* **Setup Git repository** — pushed to GitHub inside `Day 25/fitness_tracker` of the `Linkific_Tasks` repository
* **Install dependencies** — 5 packages added with `flutter pub add`
* **Configure Firebase** — Firebase project, Email/Password sign-in, Firestore database, security rules and `flutterfire configure`
* **Create folder structure** — folders and files from the architecture phase created under `lib/`

### Team Collaboration

* **Assign tasks** — 7 tasks in build order, all assigned to one person
* **Git workflow** — no direct commits to `main`, one branch per task, merge only through a pull request
* **Code review process** — a written checklist before every merge
* **Daily standup schedule** — 9:00 AM, 10 minutes, three written lines (done, doing, blocked)
* Full details are in `docs/task-breakdown.md`

## Application Planned

### fitness_tracker

A Flutter app with a Firebase backend where a user signs up, logs workouts, sees a 7-day progress chart, sets goals, tracks water and calculates BMI. Only the planning and setup are done.

## Packages Used

Each package is used for one listed item only.

| Package | Used for |
|---|---|
| `firebase_core` | Connecting the app to Firebase |
| `firebase_auth` | User authentication |
| `cloud_firestore` | Saving workouts, water entries and goals (data persistence) |
| `provider` | State management |
| `fl_chart` | Progress charts |

## Concepts Learned

### Planning before building

Features, screens, data and folders are decided first, so each later step has a clear target and nothing extra is added.

### Cloud Firestore and Realtime Database are different products

Firebase has two databases with similar names. Each has its own Rules tab and its own rules language. This app uses Cloud Firestore.

### Security rules limit each user to their own data

All data is stored under the user's own ID, and the rules allow read and write only when the logged-in user's ID matches.

### A repository inside a repository does not push properly

The app folder had its own `.git` folder inside the larger `Linkific_Tasks` repository. It had to be moved out before the app could be pushed as part of the larger repository.

## Important Issues Encountered

1. `Error saving rules - Line 1: Parse error` — the rules were pasted on the Realtime Database page instead of the Cloud Firestore page. Fixed by opening Firestore Database, then Rules.
2. `Repository not found` on `git pull` — the remote address still had the placeholder `YOUR_USERNAME`. Fixed with `git remote set-url`.
3. `non-fast-forward` rejection on `git push` — the `Linkific_Tasks` repository already had commits, and the app folder had its own separate `.git`. Fixed by moving the inner `.git` out and pushing from the `Linkific_Tasks` folder, without forcing the push.
4. `Invalid VCS root mapping` in Android Studio — the old mapping pointed at the removed inner repository. Fixed by removing it in the Directory Mappings settings.
5. `UnknownHostException` for `firestore.googleapis.com` on the emulator — the emulator had no working internet. Fixed after the emulator's internet connection was restored.

## Current Verification Status

* **Flutter project:** created and runs
* **Firebase:** connected, and the Firestore connection error on the emulator is resolved
* **flutter analyze:** not run yet
* **Not done:** the 7 app features are not built, because the task covers planning and setup only. CI/CD, deployment and store publishing are not part of the task

## Final Verification Checklist

### Learning Objectives
* [x] Plan complete Flutter application
* [x] Design architecture
* [x] Create wireframes
* [x] Setup project

### Team Formation
* [ ] Form teams of 2–3 interns (not done: the mentor instructed to complete the task individually)

### Brainstorm Project Ideas
* [x] A. Social Media App: user authentication, create posts with images, like and comment, user profiles, follow system, news feed, real-time notifications (considered, not chosen)
* [x] B. E-commerce App: product catalog, shopping cart, checkout flow, order history, search and filters, user authentication, payment UI (Stripe test mode) (considered, not chosen)
* [x] C. Chat Application: real-time messaging, Firebase/Supabase backend, group chats, image sharing, push notifications, user profiles, online status (considered, not chosen)
* [x] D. Fitness Tracker: workout logging, progress charts, goal setting, BMI calculator, water intake tracker, user authentication, data persistence (selected)

### Define Requirements
* [x] List all features
* [x] User flows
* [x] Screens needed
* [x] API requirements
* [x] Database schema

### Design Architecture
* [x] State management choice
* [x] Backend choice
* [x] Package selection
* [x] Folder structure

### Create Wireframes
* [x] Sketch all screens
* [x] Navigation flow
* [x] UI components

### Setup Project
* [x] Initialize Flutter project
* [x] Setup Git repository
* [x] Install dependencies
* [x] Configure Firebase/Supabase
* [x] Create folder structure

### Team Collaboration
* [x] Assign tasks
* [x] Git workflow
* [x] Code review process
* [x] Daily standup schedule

### Deliverables
* [x] Project proposal — `docs/proposal.md`
* [x] Wireframes/mockups — `docs/wireframes/`
* [x] Architecture document — `docs/architecture.md`
* [x] GitHub repository — `Linkific_Tasks`, folder `Day 25/fitness_tracker`
* [x] Task breakdown — `docs/task-breakdown.md`
* [x] Team roles defined — `docs/team-roles.md`

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

### Create the project and install the packages (already done)

```bash
flutter create fitness_tracker
flutter pub add firebase_core firebase_auth cloud_firestore provider fl_chart
```

### Connect Firebase (already done)

```bash
dart pub global activate flutterfire_cli
flutterfire configure
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
git checkout -b feature/auth
git add "Day 25/fitness_tracker"
git commit -m "Short message"
git push -u origin feature/auth
```

Then open a pull request on GitHub and merge it. Always add only the `Day 25/fitness_tracker` folder, never `git add .`.

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
│   └── wireframes/
│       ├── wireframes.md
│       └── 01-login.jpg ... 08-bmi-calculator.jpg
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
│   │   ├── login_screen.dart
│   │   ├── signup_screen.dart
│   │   ├── workout_list_screen.dart
│   │   ├── add_edit_workout_screen.dart
│   │   ├── progress_charts_screen.dart
│   │   ├── goals_screen.dart
│   │   ├── water_tracker_screen.dart
│   │   └── bmi_calculator_screen.dart
│   └── widgets/
│       └── main_bottom_nav.dart
├── firebase.json
├── pubspec.yaml
└── README.md
```

The folders and files under `lib/` were created in the setup step. Their code is not written yet.

## Wireframes

| | | | |
|---|---|---|---|
| <img src="docs/wireframes/01-login.jpg" width="200"><br>Login | <img src="docs/wireframes/02-signup.jpg" width="200"><br>Sign Up | <img src="docs/wireframes/03-workout-list.jpg" width="200"><br>Workout List | <img src="docs/wireframes/04-add-edit-workout.jpg" width="200"><br>Add/Edit Workout |
| <img src="docs/wireframes/05-progress-charts.jpg" width="200"><br>Progress Charts | <img src="docs/wireframes/06-goals.jpg" width="200"><br>Goals | <img src="docs/wireframes/07-water-tracker.jpg" width="200"><br>Water Tracker | <img src="docs/wireframes/08-bmi-calculator.jpg" width="200"><br>BMI Calculator |

## Resources

* https://docs.flutter.dev
* https://firebase.google.com/docs/flutter/setup
* https://pub.dev/packages/provider
* https://pub.dev/packages/fl_chart

## Conclusion

Day 25 covered choosing a project, defining requirements, designing the architecture, creating wireframes, setting up the Flutter project with Firebase and Git, and defining the task, Git, review and standup process for working alone. The main lessons were that planning decides what is built and what is left out, that Cloud Firestore and Realtime Database are separate products, and that checking which Git repository you are in before pushing avoids errors. The app features are not built yet, because this task covers planning and setup only.
