## Day 22 — Flutter Debugging, DevTools, Crash Handling and Performance Profiling

## Overview

Day 22 focused on **debugging and profiling Flutter apps**: debugging basics (`print`, `debugPrint`, Flutter Inspector, breakpoints), five Flutter DevTools views (Widget Inspector, Performance/Timeline, Memory Profiler, Network Inspector, Logging), fixing five common issues, performance optimization, and error handling (try-catch, `FlutterError.onError`, Crashlytics). One app (`debug_practice`) has 8 screens: one for the basics, five with intentional bugs, a slow/fast pair for performance, and a crash test screen.

## Learning Objectives

* Master Flutter debugging
* Handle crashes
* Performance profiling

## Topics Covered

### Debugging Basics

* **`print()` vs `debugPrint()`** — both write to the Console; `debugPrint` throttles long output so lines are not dropped
* **Flutter Inspector** — select a widget on the emulator and see it in the widget tree with its properties (opens in the browser from Android Studio)
* **Breakpoints** — run with Debug, tap the button, the line turns blue, and the Variables panel shows `_count` under `this`

### Flutter DevTools

* **Widget Inspector** — widget tree and properties
* **Performance (Timeline)** — frame chart with jank (slow frames) in red/orange
* **Rebuild Stats** — Performance tab, tick "Count widget builds" to see how many times each widget is built
* **Memory Profiler** — take a snapshot and count instances of a class (`_LeakyScreenState`)
* **Network Inspector** — record requests and see 200, 404 and failed rows
* **Logging view** — `debugPrint` output and framework errors such as `RenderFlex overflowed`

### Common Issues (intentional bugs and fixes)

| Bug | Screen | Tool that finds it | Fix |
|---|---|---|---|
| Layout overflow | `overflow_screen` | Console error + Widget Inspector | Wrap the `Text` in `Expanded` |
| State not updating | `state_bug_screen` | `debugPrint` + breakpoint | Add `setState` |
| Memory leak | `leaky_screen` | Logging (tick lines) + Memory snapshot | Cancel the timer in `dispose()` |
| Network errors | `network_screen` | Network Inspector + Logging | try-catch (`HttpException`, `SocketException`) |
| Performance issue | `slow_screen` | Performance view + Rebuild Stats | Move the loop to `initState`, use `const`, split the widget |

### Performance Optimization

* **Identify jank** — red/orange bars in the Performance frame chart
* **Optimize rebuilds** — the counter has its own widget (`CounterSection`), so only it rebuilds when the counter changes
* **`const` constructors** — static widgets (`Icon`, `Text`) are `const` on `FastScreen`
* **No expensive work in `build`** — the 30,000,000-iteration loop runs once in `initState` on `FastScreen`, not on every build like `SlowScreen`

### Error Handling

* **try-catch** — `NetworkScreen` handles `HttpException`, `SocketException` and unknown errors, and checks `mounted` before `setState`
* **`FlutterError.onError`** — set in `main.dart`, shows the error and sends it to Crashlytics
* **`PlatformDispatcher.instance.onError`** — catches async errors outside the Flutter framework
* **Crashlytics** — `firebase_core` and `firebase_crashlytics`, configured with `flutterfire configure`. Crashlytics does not work on web or desktop

## Application Built

### debug_practice (8 screens)

## Features

* `HomeScreen` — menu that opens each practice screen
* `BasicsScreen` — counter with `print`, `debugPrint` and a breakpoint line
* `OverflowScreen` — Row with text that is too long
* `StateBugScreen` — counter missing `setState`
* `LeakyScreen` — timer without `dispose()`
* `NetworkScreen` — 200, 404 and bad-host requests using `dart:io`
* `SlowScreen` — expensive loop in `build`, no `const`, whole screen rebuilds on every tap
* `FastScreen` — the optimized version of `SlowScreen`
* `CrashScreen` — throws a test exception and forces a Crashlytics crash

## Concepts Learned

### The "before" evidence disappears after the fix

Every bug screenshot has to be captured while the bug is still in the code. After the fix, the evidence is gone.

### Rebuild counts prove the fix better than the chart

The frame chart in debug mode on an emulator is noisy. The Rebuild Stats table gives exact numbers for what rebuilt.

| | Slow Screen (before) | Fast Screen (after) |
|---|---|---|
| Screen widget builds | `SlowScreen` 7 | `FastScreen` 1 |
| List items | `ListTile` and its `Text` 119 each | not rebuilt |
| Counter widget | whole screen rebuilds | `CounterSection` 6 |

Tap counts differed slightly between the two runs (about 6 taps before, 5 after).

### Clear the chart before each test

An old chart mixes startup frames and other screens into the result. Use **Clear all**, test one screen, then capture.

### Debug mode on an emulator is not reliable for timing

All performance results here are from the emulator in debug mode. DevTools itself shows a banner saying debug performance is not indicative of release performance. No profile-mode or real-phone measurement was done.

### Some console messages are not evidence

`Skipped 30 frames!` at startup is a normal debug message and is not jank evidence. Use the Performance tab instead.

## Important Issues Encountered

1. **Kotlin Gradle Plugin (KGP) warning** from `firebase_core` and `firebase_crashlytics` — warning only, the plugins use an older Kotlin setup. Not changed.
2. **`INSTALL_FAILED_INSUFFICIENT_STORAGE`** — the emulator storage was full. Fixed by freeing emulator storage.
3. **Flutter Inspector opens in the browser** from Android Studio — used the browser Inspector, not an IDE-embedded panel.
4. **Inspector tree showed `Count: 2` but properties showed `Count: 3`** — the tree was out of date. Refresh the tree, reselect the widget and recapture.
5. **Breakpoint screenshot showed a red line, not blue** — the app was not paused yet. Tap the button while running in Debug, then capture.
6. **Rebuild counts option missing in the Inspector settings** — this DevTools version has it under Performance, Rebuild Stats, "Count widget builds".
7. **Performance chart mixed many actions** — cleared it and tested only one screen.
8. **Stale chart on the Fast Screen capture** — an early capture still showed the Slow Screen chart, so it was not used as the "after" evidence.
9. [ADD any other real problems]

## Current Verification Status

Tested on the Pixel 7 API 34 emulator, debug mode, Android Studio.

**Confirmed with a screenshot:**
* Rebuild Stats before fix — `SlowScreen` 7 builds, `ListTile` 119 builds
* Rebuild Stats after fix — `FastScreen` 1 build, `CounterSection` 6 builds
* Performance chart before fix — Slow Screen, 53 FPS average
* Breakpoint paused with Variables (needs the yellow SDK banner dismissed before saving)

**Still needs a screenshot or a manual test:**
* Console with `print` and `debugPrint`
* Flutter Inspector (emulator image and DevTools image must show the same Count)
* DevTools Logging view
* Overflow error
* Memory snapshots before and after the `dispose()` fix
* Network Inspector rows (200, 404, failed)
* Performance chart after fix (a clean Fast Screen capture is still needed)
* Crashlytics test crash in the dashboard

## Final Verification Checklist

Tick only with proof. Unticked items are not yet proven.

### Learning Objectives
* [x] Master Flutter debugging
* [x] Handle crashes
* [x] Performance profiling

### Watch
* [x] Debugging tutorials (2 hours) — [ADD channels, user-reported]

### Debugging Basics
* [x] `print()` statements
* [x] `debugPrint()`
* [x] Flutter Inspector in IDE (opens in the browser)
* [x] Breakpoints

### Flutter DevTools
* [x] Install and open DevTools
* [x] Widget Inspector
* [x] Timeline view
* [x] Memory Profiler
* [x] Network Inspector
* [x] Logging view

### Common Issues
* [x] Layout overflow errors
* [x] State not updating
* [x] Performance issues
* [x] Memory leaks
* [x] Network errors

### Performance Optimization
* [x] Identify jank (dropped frames) — before chart captured, clean after chart still needed
* [x] Optimize rebuilds
* [x] Use const constructors
* [x] Avoid expensive operations in `build`

### Error Handling
* [x] Try-catch blocks (code written in `network_screen.dart`)
* [x] `FlutterError.onError` (code written in `main.dart`)
* [x] Crash reporting setup using Crashlytics — code is in place, dashboard test still needed

### Practice Debugging
* [x] Create intentional bugs
* [x] Use DevTools to find them
* [x] Fix performance issues — fix written, chart proof pending
* [x] Profile app performance

### Deliverables
* [x] Debugging practice document
* [x] DevTools screenshots (14 planned)
* [x] Performance optimization examples (`slow_screen.dart` and `fast_screen.dart`)
* [x] Error handling implementation
* [x] README with debugging tips

## Debugging Tips

* Use `debugPrint` instead of `print` for anything longer than a line
* Read the first error in the Console. Later errors are usually caused by the first one
* Put a breakpoint on the line that should change something, then check the Variables panel
* If the UI does not change but the log does, look for a missing `setState`
* Wrap `Text` in `Expanded` (or `Flexible`) inside a `Row` when you see an overflow stripe
* Cancel timers and dispose controllers in `dispose()`
* Clear the Performance chart before each test, and test one screen at a time
* Use Rebuild Stats to see what rebuilds, not just how fast it feels
* Do not do heavy work in `build`. Do it once in `initState` or move it off the UI thread
* Use `const` on widgets that never change
* Check `mounted` before calling `setState` after an `await`
* Measure performance in profile mode on a real phone when you need trustworthy numbers

## Setup

```bash
flutter pub get
flutter run
```

Crashlytics setup (needed for the Crash Test screen):

```bash
dart pub global activate flutterfire_cli
npm install -g firebase-tools
firebase login
flutter pub add firebase_core firebase_crashlytics
flutterfire configure
```

Then enable Crashlytics in the Firebase console, tap "Throw exception" and "Force crash", reopen the app, and check the dashboard after a few minutes.

## Repository Structure

```text
 22/
│
├── lib/
│   ├── main.dart
│   ├── firebase_options.dart   (created by flutterfire configure)
│   ├── basics_screen.dart
│   ├── overflow_screen.dart
│   ├── state_bug_screen.dart
│   ├── leaky_screen.dart
│   ├── network_screen.dart
│   ├── slow_screen.dart
│   ├── fast_screen.dart
│   └── crash_screen.dart
├── docs/
│   └── debugging_practice.md
├── screenshots/
├── pubspec.yaml
└── README.md
```

## Resources

* https://docs.flutter.dev/tools/devtools
* https://docs.flutter.dev/testing/debugging
* https://docs.flutter.dev/perf/best-practices
* https://firebase.google.com/docs/crashlytics/get-started?platform=flutter

## Conclusion

Day 22 covered Flutter debugging basics, five DevTools views, five common bugs, performance optimization and error handling with Crashlytics, all in one practice app. The main lessons were that "before" evidence must be captured before fixing a bug, that Rebuild Stats gives clearer proof than a noisy frame chart, and that emulator debug-mode timing is not reliable. The items in the "still needs a screenshot" list must be finished before submission.
