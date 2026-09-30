## Day 23 — Flutter Testing: Unit Tests, Widget Tests and Test Coverage

## Overview

Day 23 focused on **testing Flutter apps**: the three test types (unit, widget, integration), writing unit tests and widget tests, setting up test files, running tests, and generating a test coverage report. Tests were written for the `debug_practice` app from Day 22, plus a small calculator, a login form, and a user model with a mocked API call.

## Learning Objectives

* Understand Flutter testing
* Write unit tests
* Write widget tests
* Test coverage basics

## Topics Covered

### Testing Types

| Type | What it tests | Purpose | Speed |
|---|---|---|---|
| **Unit test** | Business logic (functions, classes, models) | Check that one piece of logic gives the right result | Very fast |
| **Widget test** | UI components | Check that a widget shows the right things and reacts to taps and typing | Fast |
| **Integration test** | Full app | Check that the whole app works together, as a real user would use it | Slow |

**Differences**

* **Size:** a unit test covers one function or class, a widget test covers one widget or screen, an integration test covers the whole app
* **Device:** unit and widget tests run without a device or emulator, integration tests need a real device or emulator
* **Failures:** a unit test failure points to a specific logic bug, an integration test failure only shows that something broke somewhere

Integration tests were explained only. None were written, as the task does not ask for them.

### Unit Tests

* **Functions and methods** — `Calculator.add`, `subtract`, `multiply`, `divide`
* **Models** — `User.fromJson` creates the correct `User`
* **Business logic** — `discountedPrice` applies the percent and rejects invalid input
* **Assertions** — `expect(actual, expected)`, plus `throwsArgumentError`, `throwsException` and `isNull`

### Widget Tests

* **Rendering** — the widget shows its title, text and button
* **User interactions** — tap, enter text and scroll change what is on screen
* **Finding widgets** — `find.byType` and `find.text`
* **Tap** — `tester.tap`
* **Enter text** — `tester.enterText`
* **Scroll** — `tester.dragUntilVisible`

### Test File Setup

* **`test/` directory** — all tests are in `test/` at the project root, next to `lib/`
* **Naming** — every file ends with `_test.dart`, which is how `flutter test` finds them
* **`setUp`** — runs before each test, creates a fresh `Calculator`
* **`tearDown`** — runs after each test, clears the calculator history

### Running Tests

* **Command** — `flutter test` (all tests) or `flutter test test/<file>_test.dart` (one file)
* **IDE** — Android Studio, right-click the `test` folder, then Run Tests
* **Coverage** — `flutter test --coverage` creates `coverage/lcov.info`. In that file `LF` is lines found and `LH` is lines hit. Coverage is `LH / LF`

## Application Tested

### debug_practice (from Day 22) plus small practice code

## Test Files

| File | Type | What it covers |
|---|---|---|
| `test/basics_screen_test.dart` | Widget | Rendering, `find.text`, `find.byType`, tap |
| `test/fast_screen_test.dart` | Widget | `CounterSection` tap (state change), scroll to the last list item |
| `test/calculator_test.dart` | Unit | Functions and methods, business logic, `expect`, `setUp`, `tearDown`, calculator |
| `test/form_validation_test.dart` | Unit and widget | Form validation, enter text |
| `test/user_test.dart` | Unit | Model, API call with a mock |

## Code Added for Testing

* `lib/calculator.dart` — `Calculator` class and `discountedPrice`
* `lib/login_form.dart` — `validateEmail` and `LoginForm`
* `lib/user.dart` — `User` model
* `lib/user_api.dart` — `fetchUser` using the `http` package

Package added: `http` (its `MockClient` is used for the mocked API test, so no extra mocking package was needed).

## Concepts Learned

### `pump()` vs `pumpAndSettle()`

`pumpAndSettle()` waits until all animations stop. `FastScreen` has a `CircularProgressIndicator` that never stops, so `pumpAndSettle()` would hang. `pump()` was used instead.

### Mocks keep tests independent of the internet

`MockClient` returns a fake response, so the API test never calls the real server. A 200 response and a 404 response were both tested.

### `main.dart` is not tested

`main.dart` calls `Firebase.initializeApp`, which does not work in tests. Each test builds its own `MaterialApp(home: ...)` around the widget it tests.

### Coverage only lists imported files

A file that no test imports does not appear in the coverage report, so the percentage can look better than the real state.

### Logic inside a widget cannot be unit tested

Business logic has to be in plain functions or classes to be unit tested. That is why the calculator and the price logic are in their own file.

## Important Issues Encountered

1. Default `test/widget_test.dart` deleted, as it tests the default counter app and is not part of this task.
2. Scroll offset `-200` was too small for the 200-item list on `FastScreen`. Changed to `-500`.
3. `pumpAndSettle()` hangs on `FastScreen` because of the endless spinner. Used `pump()`.
4. [ADD any other real problems]

## Current Verification Status

* **Tests run:** 16 tests, all passed
* **Command:** `flutter test` output screenshot: <img width="474" height="158" alt="image" src="https://github.com/user-attachments/assets/dcc545d3-cc0a-4112-adbc-6f9f617db20a" />

* **IDE run:** screenshot: <img width="1898" height="721" alt="image" src="https://github.com/user-attachments/assets/ec6ebd7b-1b71-4ca6-bcab-7b80441ca35f" />

* **Coverage:** 98.9% of lines hit (86 of 87), from `coverage/lcov.info`
* **Not fully covered:** `lib/calculator.dart` line 29 (the invalid-input throw in `discountedPrice`)
* **Not in the report:** `main.dart` and the other Day 22 screens, because no test imports them

## Final Verification Checklist

### Learning Objectives
* [x] Understand Flutter testing
* [x] Write unit tests
* [x] Write widget tests
* [x] Test coverage basics

### Watch
* [x] Testing tutorials (2 hours) — [ADD channels]

### Testing Types
* [x] Unit tests — business logic
* [x] Widget tests — UI components
* [x] Integration tests — full app (explained only)

### Unit Tests
* [x] Test functions and methods
* [x] Test models
* [x] Test business logic
* [x] Assertions using `expect`

### Widget Tests
* [x] Test widget rendering
* [x] Test user interactions
* [x] Find widgets using `find.byType`
* [x] Find widgets using `find.text`
* [x] Test tap
* [x] Test enter text
* [x] Test scroll

### Test File Setup
* [x] `test/` directory
* [x] `*_test.dart` naming convention
* [x] `setUp`
* [x] `tearDown`

### Running Tests
* [x] `flutter test` command
* [x] Run tests in IDE
* [x] Test coverage report

### Practice Testing
* [x] Write tests for calculator
* [x] Test form validation
* [x] Test API calls with mocks
* [x] Test state management — `CounterSection` tap test with `setState`

### Deliverables
* [x] Test files for previous apps — `debug_practice` (Day 22)
* [x] Unit tests for business logic
* [x] Widget tests for UI
* [x] Test coverage report — `coverage/lcov.info`
* [x] README with testing guide

## Testing Guide

### Setup

```bash
flutter pub get
```

### Run all tests

```bash
flutter test
```

### Run one file

```bash
flutter test test/calculator_test.dart
```

### Run in Android Studio

Right-click the `test` folder (or one test file), then choose Run Tests.

### Generate the coverage report

```bash
flutter test --coverage
```

The report is `coverage/lcov.info`. Optional HTML view, if `lcov` is installed:

```bash
genhtml coverage/lcov.info -o coverage/html
```

### Testing tips

* Keep logic in plain functions or classes so it can be unit tested
* Give each test one job and one clear name
* Use `setUp` for fresh objects and `tearDown` for cleanup
* Use `pump()` when a screen has an endless animation
* Use a mock client for API tests, never the real server
* Run `flutter test` from the project root, where `pubspec.yaml` is
* A failing test is useful. Read the message before changing the code

## Repository Structure

```text
debug_practice/
│
├── lib/
│   ├── main.dart
│   ├── basics_screen.dart
│   ├── fast_screen.dart
│   ├── calculator.dart
│   ├── login_form.dart
│   ├── user.dart
│   ├── user_api.dart
│   └── ... (other Day 22 screens)
├── test/
│   ├── basics_screen_test.dart
│   ├── fast_screen_test.dart
│   ├── calculator_test.dart
│   ├── form_validation_test.dart
│   └── user_test.dart
├── coverage/
│   └── lcov.info
├── screenshots/
├── pubspec.yaml
└── README.md
```

## Resources

* https://docs.flutter.dev/testing/overview
* https://docs.flutter.dev/cookbook/testing/unit/introduction
* https://docs.flutter.dev/cookbook/testing/unit/mocking
* https://docs.flutter.dev/cookbook/testing/widget/introduction

## Conclusion

Day 23 covered the three Flutter test types, unit tests, widget tests, test file setup with `setUp` and `tearDown`, running tests from the command line and the IDE, and a coverage report. The main lessons were that logic must be outside widgets to be unit tested, that `pumpAndSettle()` hangs on endless animations, and that a mocked client keeps API tests fast and offline.
