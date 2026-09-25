# Day 19 - Flutter Provider (State Management)

## Overview

Day 19 focused on **Provider** — a state management package for Flutter that makes state available across the widget tree without manually passing it down through constructors. The app, `provider_app`, uses `ChangeNotifier` classes for Counter, Todo, Cart, and Auth state, wired together with `MultiProvider`, and demonstrates `ProxyProvider`, `FutureProvider`, and `StreamProvider` alongside them.

## Learning Objectives

* Understand Provider package
* Implement state management
* Use ChangeNotifier
* Consumer and Provider patterns

## Topics Covered

### Package Setup

* Installed `provider` package via `flutter pub add provider`
* Read official docs at https://pub.dev/packages/provider

### Provider Concepts

* **Why use Provider** — avoids prop drilling (passing state manually through many widget constructors); makes state available anywhere below it in the tree
* **Provider vs setState** — `setState` rebuilds only the widget it's called in and is best for local/ephemeral state (e.g. one text field); Provider shares state across multiple screens/widgets and only rebuilds the widgets actually listening
* **Provider types** — `Provider`, `ChangeNotifierProvider`, `MultiProvider`, `FutureProvider`, `StreamProvider`, `ProxyProvider`

### ChangeNotifier

* `ChangeNotifier` classes created for `CounterModel`, `TodoModel`, `CartModel`, `AuthModel`
* `notifyListeners()` called after every state mutation to trigger UI rebuilds
* Private state (e.g. `_count`, `_todos`) exposed via public getters

### Setup Provider

* `ChangeNotifierProvider` used to register each ChangeNotifier
* `MultiProvider` used in `main.dart` to combine all providers (Counter, Todo, Cart, Auth, ProxyProvider, FutureProvider, StreamProvider) in one place above `MaterialApp`, so state survives navigation between screens
* Provider scope: state is only accessible to widgets *below* where it's provided in the tree

### Consume State

All four consumption patterns implemented and compared:

* `Consumer<T>` widget — rebuilds only its own subtree
* `Provider.of<T>(context)` — rebuilds the calling widget
* `context.watch<T>()` — shorthand for `Provider.of`, used in `build()`
* `context.read<T>()` — no rebuild, used inside callbacks (e.g. `onPressed`)

### Provider Patterns

* **Multiple providers** — Counter, Todo, Cart, Auth all registered via `MultiProvider`
* **ProxyProvider** — builds a greeting string from `AuthModel`'s login state
* **FutureProvider** — exposes a one-time simulated async value (`'Loading...'` → `'Loaded data'`)
* **StreamProvider** — exposes a repeating value via `Stream.periodic` (ticks every second)

## Application Built

### `provider_app`

## Features

* `HomeScreen` — navigation hub with buttons to Counter, Todo, Cart, and Auth screens
* `CounterScreen` — increment/decrement using `ChangeNotifier`, demonstrates all four consumption patterns side by side
* `TodoScreen` — add, toggle complete, and delete todos via `Consumer` + `context.read`
* `CartScreen` — add products to cart, running total shown via `Consumer`
* `AuthScreen` — login/logout toggling `AuthModel` state, shown via `context.watch`

## Concepts Learned

### State placed above `MaterialApp` survives navigation

Because `CartModel`, `TodoModel`, `AuthModel`, and `CounterModel` are provided above `MaterialApp` via `MultiProvider` rather than inside individual screens, navigating away from a screen and back does not reset its state (e.g. cart items persist across navigation). State scoped inside a single screen would be destroyed when that screen is popped.

### Providers of the same type can silently shadow each other

Registering `ProxyProvider<AuthModel, String>` and `FutureProvider<String>` in the same `MultiProvider` list means both expose a `String` type. `context.watch<String>()` does not throw an error — it simply resolves to whichever matching provider is nearest in the tree, silently shadowing the other. This does not crash the app, but it means only one of the two `String` values is actually reachable through that call, which can look like the app is "working" while quietly returning the wrong value. Fixed by wrapping the `ProxyProvider`'s output in a distinct `Greeting` class (`ProxyProvider<AuthModel, Greeting>`) so it no longer collides with `FutureProvider<String>`.

### `read` vs `watch` is about where the call sits, not just style

`context.watch<T>()` inside `build()` causes rebuilds on every state change; using it inside a callback like `onPressed` would rebuild unnecessarily or throw errors in some contexts. `context.read<T>()` is the correct choice for one-off calls that don't need to listen for future changes.

## Important Issues Encountered

**Root cause, in the order it surfaced:**
1. `ProxyProvider<AuthModel, String>` and `FutureProvider<String>` were both typed as `String` in the same `MultiProvider` list. `context.watch<String>()` resolved to the `FutureProvider` value only — the `ProxyProvider` greeting was registered but unreachable through that call.

Resolution: fixed by introducing a small `Greeting` wrapper class and retyping the provider as `ProxyProvider<AuthModel, Greeting>`, consumed via `context.watch<Greeting>().text`. Both values are now independently reachable.

## Current Verification Status

The app compiles and runs end-to-end with `HomeScreen` navigating to all four screens. The `ProxyProvider`/`FutureProvider` type clash has been fixed and confirmed working. **Individual interactions inside each screen (Todo add/toggle/delete, Cart add/total, Auth login/logout, FutureProvider loading transition, StreamProvider tick) were not individually confirmed one by one.** Confirm the checklist below before treating Day 19 as fully complete.

## Final Verification Checklist

* [x] `flutter pub get` completes with no errors
* [x] App runs and `HomeScreen` navigates to all four screens
* [ ] Counter increments/decrements correctly via all four consumption methods
* [ ] Todo add/toggle/delete confirmed working
* [ ] Cart add-item and running total confirmed working
* [ ] Auth login/logout confirmed working
* [ ] FutureProvider transitions from `'Loading...'` to `'Loaded data'` after 2 seconds
* [ ] StreamProvider value increments every second on screen
* [x] ProxyProvider greeting reachable and correct (fixed via `Greeting` wrapper type)
* [ ] No debug `print`/test calls left in `main.dart` in the final version

## Repository Structure

```text
Day 19/
│
├── provider_app/
│   ├── lib/
│   │   ├── main.dart
│   │   ├── models/
│   │   │   ├── counter_model.dart
│   │   │   ├── todo_model.dart
│   │   │   ├── cart_model.dart
│   │   │   └── auth_model.dart
│   │   └── screens/
│   │       ├── home_screen.dart
│   │       ├── counter_screen.dart
│   │       ├── todo_screen.dart
│   │       ├── cart_screen.dart
│   │       └── auth_screen.dart
│   ├── pubspec.yaml
│   └── README.md
└── README.md
```

## Resources

provider package documentation:
https://pub.dev/packages/provider

## YouTube Search Terms

* Flutter Provider complete tutorial
* Provider state management
* ChangeNotifier Flutter
* Provider vs setState
* Flutter state management comparison

## Recommended Channels

* Reso Coder
* The Net Ninja
* Flutter Official

## Conclusion

Day 19 covered Provider-based state management in Flutter — `ChangeNotifier`, `ChangeNotifierProvider`, `MultiProvider`, the four state-consumption patterns (`Consumer`, `Provider.of`, `watch`, `read`), and the three advanced patterns (`ProxyProvider`, `FutureProvider`, `StreamProvider`), applied across Counter, Todo, Cart, and Auth features in one app. A type clash between `ProxyProvider<AuthModel, String>` and `FutureProvider<String>` initially caused the ProxyProvider's value to be silently shadowed rather than throwing an error — a reminder that "the app runs" is not the same as "every provider is actually reachable." This was fixed by giving the ProxyProvider a distinct return type. As with prior days, the app was built and run once as a whole, but a full pass through the verification checklist above — particularly the individual screen interactions — is still pending before this can be marked fully complete.
