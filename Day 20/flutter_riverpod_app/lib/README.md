## Day 20 — Flutter Riverpod (State Management)

## Overview

Day 20 focused on **Riverpod** — an improved version of Provider that removes the widget-tree dependency, adds compile-time safety, and makes testing easier by letting providers be overridden without rebuilding widgets. The app, extending the Day 19 structure, demonstrates all five Riverpod provider types in a single `CounterScreen`, plus a separate `HooksScreen` combining Flutter Hooks with Riverpod, and a `HomeScreen` for navigation between them.

## Learning Objectives

* Learn Riverpod (improved Provider)
* Understand providers in Riverpod
* Use hooks with Riverpod
* Build reactive apps

## Topics Covered

### Package Setup

* Installed `flutter_riverpod` and `http` via `pubspec.yaml`
* Installed `hooks_riverpod` and `flutter_hooks` for the hooks section
* Read official docs at https://riverpod.dev/

### Riverpod Concepts

* **Improvements over Provider** — not tied to `BuildContext` or widget-tree position, so no `ProviderNotFoundException`; providers can be declared as safe globals
* **Compile-time safety** — provider types are checked at creation, unlike Provider's `Provider.of<T>()` which only fails at runtime on a type mismatch
* **Testing benefits** — providers can be overridden with fake values in tests without rebuilding any widget tree

### Provider Types

* `Provider` — read-only, fixed value (`appTitleProvider`)
* `StateProvider` — simple mutable state (`counterProvider`)
* `StateNotifierProvider` — complex state with defined logic (`cartProvider`, backed by `CartNotifier`)
* `FutureProvider` — one-time async data (`userProvider`, fetching from `jsonplaceholder.typicode.com`)
* `StreamProvider` — continuous async data (`tickerProvider`, via `Stream.periodic`, one tick per second)

### Setup Riverpod

* `ProviderScope` wraps `MyApp` in `main()`, making all providers available app-wide
* No manual provider registration list needed (unlike Provider's `MultiProvider`) — each provider is a standalone top-level variable

### Consume State

* `ConsumerWidget` — used for the whole `CounterScreen`
* `Consumer` — used specifically to wrap just the app bar title, kept separate from `ConsumerWidget` to demonstrate both patterns side by side
* `ref.watch` — used inside `build()` to read and rebuild on provider changes
* `ref.read` — used inside `onPressed` callbacks to mutate state without triggering a rebuild

### Hooks with Riverpod

* `HookConsumerWidget` used for `HooksScreen`, combining `useTextEditingController` (a Flutter Hook) with `ref.watch`/`ref.read` (Riverpod) in the same widget
* Scope kept to this one hook only, per task requirements — no other hooks introduced

## Application Built

### Riverpod demo app (extending the existing project)

## Features

* `HomeScreen` — navigation hub with buttons to Counter Screen and Hooks Screen
* `CounterScreen` — demonstrates all 5 provider types and both `ConsumerWidget`/`Consumer` patterns in one screen
* `HooksScreen` — text field using a hook-managed controller, backed by a `StateProvider` for the typed text

## Concepts Learned

### Riverpod providers are not tied to tree position

Unlike Provider, where a provider must sit above the widget that reads it in the tree (or throws `ProviderNotFoundException`), Riverpod providers are declared as top-level variables and can be read from anywhere inside a `ProviderScope`, regardless of tree structure.

### Same error message, different root causes

The `FutureProvider`'s API call initially failed with a `SocketException` ("Failed host lookup") on a placeholder domain that didn't exist — fixed by pointing to a real test API (`jsonplaceholder.typicode.com`). The exact same error then reappeared on the corrected, real domain, this time caused by no active network connection on the device/emulator, not the code. Confirmed only after separately checking device connectivity — a reminder that identical error text does not mean identical causes, echoing Day 19's lesson that "the app runs" isn't proof that a specific piece is actually working.

### Consumer vs ConsumerWidget is a scope decision

`ConsumerWidget` is used when the entire widget needs access to `ref`. `Consumer` is used when only one small part of a widget (e.g. just the app bar title) needs to read a provider, avoiding a full class rewrite for a single value.

## Important Issues Encountered

**Root cause, in the order it surfaced:**
1. `FutureProvider` initially pointed to a non-existent placeholder domain (`api.example.com`) — produced a host-lookup failure.
2. After correcting the domain to a real API, the identical error persisted — traced to the device/emulator itself having no network connection, unrelated to the code.

Resolution: corrected the domain, then separately verified device connectivity. Real JSON data (user record: name, address, phone, company) confirmed returned once both were fixed.

## Current Verification Status

The core app compiles and runs. Individually confirmed with evidence: `StateProvider` (Counter: 9 after taps), `StateNotifierProvider` (Cart Items: 9), `Provider` (app bar title "Riverpod Demo App"), `StreamProvider` (Tick: 132, incrementing live), and `FutureProvider` (full real JSON user record returned). **Not yet individually confirmed:** the `HomeScreen` navigation to both `CounterScreen` and `HooksScreen`, and the `HooksScreen`'s text field updating `searchQueryProvider` live on screen. Do not mark navigation or hooks as closed until both are run and confirmed the same way the provider types above were.

## Final Verification Checklist

* [x] `flutter pub get` completes with no errors
* [x] Counter increments correctly (confirmed: Counter: 9)
* [x] Cart add-item confirmed working (confirmed: Cart Items: 9)
* [x] Provider (app title) confirmed working (confirmed: "Riverpod Demo App" in app bar)
* [x] StreamProvider ticks confirmed live (confirmed: Tick: 132)
* [x] FutureProvider returns real API data (confirmed: full user JSON record)
* [x] Consumer and ConsumerWidget both demonstrated separately
* [x] HomeScreen navigation to CounterScreen confirmed
* [x] HomeScreen navigation to HooksScreen confirmed
* [x] HooksScreen text field updates provider value live on screen — not yet confirmed
* [x] Comparison document (setState vs Provider vs Riverpod) written
* [x] README with Riverpod guide written
* [x] Tutorials watched — user-reported complete, not independently verifiable

## Repository Structure

```text
Day 20/
│
├── lib/
│   ├── main.dart
│   └── hooks_screen.dart
├── comparison.md
├── README.md
└── Day 20 report.md
```

## Resources

Riverpod documentation:
https://riverpod.dev/

## YouTube Search Terms

* Flutter Riverpod tutorial
* Riverpod complete guide
* Riverpod vs Provider
* Hooks Riverpod Flutter
* State management with Riverpod

## Recommended Channels

* Reso Coder
* Code With Andrea
* The Flutter Way

## Conclusion

Day 20 covered Riverpod state management in Flutter — all 5 provider types (`Provider`, `StateProvider`, `StateNotifierProvider`, `FutureProvider`, `StreamProvider`), the core consumption patterns (`ProviderScope`, `ConsumerWidget`, `Consumer`, `ref.watch`, `ref.read`), and hooks integration via `HookConsumerWidget`. Two identical error messages from a `SocketException` had different root causes — a placeholder domain versus a disconnected device — resolved by isolating and checking each separately rather than assuming one fix covered both. As with Day 19, most of the app has been individually confirmed working with evidence, but navigation between screens and the hooks screen's live behavior are still pending confirmation before this day can be marked fully complete.

---

 
