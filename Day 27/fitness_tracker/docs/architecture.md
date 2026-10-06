# Architecture Document

## State Management Choice
Provider. It is simple and enough for the 7 features of this app.

## Backend Choice
Firebase:
- Firebase Authentication for user login.
- Cloud Firestore for saved data (data persistence).

## Package Selection
- firebase_core: connects the app to Firebase.
- firebase_auth: user authentication.
- cloud_firestore: saving workouts, water entries and goals.
- provider: state management.
- fl_chart: progress charts.

## Folder Structure
```
lib/
├── main.dart
├── firebase_options.dart
├── models/
│   ├── workout.dart
│   ├── water_log.dart
│   └── goal.dart
├── services/
│   ├── auth_service.dart
│   └── firestore_service.dart
├── providers/
│   ├── auth_provider.dart
│   ├── workout_provider.dart
│   ├── water_provider.dart
│   └── goal_provider.dart
├── screens/
│   ├── login_screen.dart
│   ├── signup_screen.dart
│   ├── workout_list_screen.dart
│   ├── add_edit_workout_screen.dart
│   ├── progress_charts_screen.dart
│   ├── goals_screen.dart
│   ├── water_tracker_screen.dart
│   └── bmi_calculator_screen.dart
└── widgets/
    └── main_bottom_nav.dart
```
Files are grouped by type. Models match the database schema in the proposal.