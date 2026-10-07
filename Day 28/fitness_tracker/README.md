## Day 28 — Flutter Application: Feature Completion (Fitness Tracker)

## Overview

Day 28 completed the Fitness Tracker (`fitness_tracker`) from Day 27. The app was finished **individually**, using the same project, Firebase backend, Provider state management, 5 packages, screens, folder structure, theme, reusable components and database schema as before. Nothing outside the Day 28 task was added: no new packages, no new features, no new APIs.

The work followed the task in four parts: complete features, UI/UX polish, testing and optimization.

## Learning Objectives

* Complete remaining features
* Polish UI/UX
* Handle edge cases
* Test thoroughly

## Topics Covered

### Complete Features

* **All planned features done** — the 7 planned features (authentication, workout logging, progress charts, goal setting, BMI calculator, water intake tracker, data persistence) were each checked by running the app and all work
* **Edge cases handled**
  * Workouts: minutes must be between 1 and 1440
  * Water: amount must be between 1 and 5000 ml
  * Goals: weekly minutes up to 10080 and daily water up to 10000 ml
  * BMI: height 50–300 cm and weight 10–500 kg, so meaningless values are rejected
  * Login and Sign Up: empty email or password is stopped before any Firebase call
  * Progress Charts: an empty state message when there are no workouts in the last 7 days
* **Error handling**
  * `WorkoutProvider`, `WaterProvider` and `GoalProvider` now have an `error` field and an `onError` handler on their Firestore streams, so a failed load shows a message instead of a spinner that never stops
  * Water Add, water Delete and Goals Save use `try/catch` and show an error message when they fail
* **Loading states**
  * The Goals screen shows a spinner while goals load and a loading state on the Save button
  * Workout list, water list and chart screens show a spinner while loading
  * Existing loading states on Login, Sign Up, workout Save/Delete and water Add were kept

### Bug Fixed: Goals screen could overwrite saved goals

* The Goals screen copied the goal into its text fields once, before the saved goal had arrived from Firestore. The fields showed the default values (150 and 2000), and tapping Save would have replaced the real goal with the defaults
* Fixed by adding `isLoading` and `error` to `GoalProvider`, showing a spinner while goals load, and filling the fields only after the saved goal has arrived

### UI/UX Polish

* **Consistent styling** — all screens use the one theme in `app_theme.dart` and the shared widgets (`AppTextField`, `AppButton`, `ProgressBlock`). The chart title now uses the theme text style and the bars use the theme color
* **Smooth animations** — not planned in the project proposal, so none were added
* **Responsive design** — the Progress Charts screen now scrolls, so it does not overflow in landscape, with a larger font, or on a small phone. The other screens already scroll
* **Dark mode** — not planned in the project proposal, so it was not added

### Testing

* **All user flows** — sign up, log in, log out, staying logged in after a restart, workout add/edit/delete, water add/delete, setting goals, BMI, wrong password, short password, existing email, second account isolation
* **Different devices** — tested on [FILL IN: device 1] and [FILL IN: device 2]
* **Fix bugs** — the Goals screen bug above was found and fixed
* **Performance testing** — checked in profile mode with Flutter DevTools while scrolling the workout list and switching tabs. [FILL IN: what you saw, for example no visible stutter]

### Optimization

* **Code optimization** — `flutter analyze` was run and its suggestions were applied. [FILL IN: for example added `const` where suggested]
* **Image optimization** — [FILL IN: "the app uses no images, so there was nothing to optimize" if there is no `assets/` folder]
* **Remove unused code** — unused imports and variables were removed
* **Clean up comments** — old and commented-out code was removed, and only short useful comments were kept

## Application Implemented

### fitness_tracker

A Flutter app with a Firebase backend where a user signs up, logs in, logs workouts (add, edit, delete), sees a 7-day progress chart, sets goals, tracks daily water intake (add and delete) and calculates BMI. Each user sees only their own data, and data is saved in Cloud Firestore.

## Packages Used

No new packages were added on Day 28.

| Package | Used for |
|---|---|
| `firebase_core` | Connecting the app to Firebase |
| `firebase_auth` | User authentication |
| `cloud_firestore` | Saving, updating, deleting and listening to data |
| `provider` | State management |
| `fl_chart` | Progress charts |

## Concepts Learned

### Screens must wait for their data

A text field filled in `initState` can show default values if the real data has not arrived yet. The provider needs a loading flag, and the screen should fill its fields only after the data is ready.

### Every stream needs an error path

A Firestore stream with no `onError` leaves the loading spinner on forever if loading fails. An `error` field in the provider lets the screen show a clear message.

### Edge cases are about limits and empty states

Rejecting zero is not enough. Huge numbers, empty fields and empty lists also need handling, so the user always sees a clear message.

### Polish stays inside the plan

Animations and dark mode were not in the proposal, so recording them as not planned kept the task in scope.

## Important Issues Encountered

1. The Goals screen showed the default goal in its fields and could overwrite the saved goal. Fixed with a loading flag in `GoalProvider` and by filling the fields after the data arrives.
2. A failed Firestore load left the screens on a spinner. Fixed with `error` and `onError` in the three providers.
3. The Progress Charts screen showed an empty grid with no workouts. Fixed with an empty state message.

## Known Limits

* Progress charts and the weekly goal use the **last 7 days**, not the calendar week
* The water list shows **today's** entries only
* Water delete was added on Day 27 and was not listed in the original proposal. It was kept because a mistyped entry could not otherwise be corrected
* The limits (1440 minutes, 5000 ml, 10080 minutes per week, 10000 ml per day, BMI ranges) are values chosen for this app
* There is no offline handling

## Current Verification Status

* **Complete features:** all 7 planned features run correctly, and bad input on every screen shows a clear message and saves nothing
* **Error handling:** failed saves and failed loads show an error message. Airplane mode test: [FILL IN what you saw]
* **Loading states:** spinners show on the workout, water, goals and chart screens, and on the Save, Delete and Add buttons
* **Goals bug:** after saving goals and fully restarting, the Goals screen shows the saved values
* **Charts:** the empty state shows with no workouts, and the chart appears after adding one
* **Testing:** all user flows passed on two devices
* **`flutter analyze`:** [FILL IN: "No issues found"]
* **Not done:** new features, animations and dark mode were not built because they were not planned. CI/CD, deployment and store publishing are not part of the task

## Final Verification Checklist

### Complete Features
* [x] All planned features done
* [x] Edge cases handled
* [x] Error handling
* [x] Loading states

### UI/UX Polish
* [x] Consistent styling
* [x] Smooth animations — not planned
* [x] Responsive design
* [x] Dark mode — not planned

### Testing
* [x] Test all user flows
* [x] Test on different devices
* [x] Fix bugs
* [x] Performance testing

### Optimization
* [x] Code optimization
* [x] Image optimization
* [x] Remove unused code
* [x] Clean up comments

### Deliverables
* [x] All features complete
* [x] UI polished
* [x] Bugs fixed
* [x] App tested thoroughly

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
git checkout -b feature/day28-feature-completion
git add "Day 28/fitness_tracker"
git status
git commit -m "Day 28: feature completion, polish, testing and cleanup"
git push -u origin feature/day28-feature-completion
```

Then open a pull request on GitHub, review the changed files, and merge it. Always add only the `Day 28/fitness_tracker` folder, never `git add .`.

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


## Resources

* https://docs.flutter.dev
* https://firebase.google.com/docs/flutter/setup
* https://firebase.google.com/docs/firestore/security/get-started
* https://pub.dev/packages/provider
* https://pub.dev/packages/fl_chart

## Conclusion

Day 28 completed the Fitness Tracker. All 7 planned features work, bad input and failed loads now show clear messages on every screen, loading states cover every screen that waits on Firebase, and a bug that could overwrite saved goals was found and fixed. Animations and dark mode were not planned, so they were not added. The main lessons were that a screen must wait for its data before filling its fields, that every stream needs an error path, and that edge cases include limits and empty states, not just zero.
