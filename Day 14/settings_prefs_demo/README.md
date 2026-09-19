# Day 14 - Flutter SharedPreferences

## Overview

Day 14 focused on using **SharedPreferences** as Flutter's built-in key-value local storage solution. A single-screen Settings app was built to demonstrate every supported data type, default-value handling, null handling, single-key removal, and full-storage clearing.

The module covered SharedPreferences setup, all five supported data types (`String`, `int`, `bool`, `double`, `List<String>`), reading with defaults, `remove(key)`, `clear()`, and applying persisted settings automatically on app restart.

A new Settings app (`settings_prefs_demo`) was built as the main deliverable, rather than migrating an existing app, since SharedPreferences is a foundational pattern rather than an extension of the Day 12/13 database work.

## Learning Objectives

* Use SharedPreferences for local key-value storage
* Store simple data across all supported types
* Handle app settings (theme, language, notifications)
* Persist user preferences across app restarts

## Topics Covered

### SharedPreferences Setup

* `shared_preferences` package
* `SharedPreferences.getInstance()`
* Key-value storage model
* Supported data types vs when to use a database instead

### Storing Data

* `setString()`
* `setInt()`
* `setBool()`
* `setDouble()`
* `setStringList()`

### Retrieving Data

* `getString()`, `getInt()`, `getBool()`, `getDouble()`, `getStringList()`
* Default values via the `?? fallback` pattern
* Handling `null` for keys that were never written

### Removing Data

* `remove(key)` — deletes a single key
* `clear()` — deletes everything

### Common Use Cases Implemented

* Remember login state
* Save theme preference (light/dark)
* Store user settings (notifications, font size, language)
* First-time launch flag
* Language preference + a favorite-languages list

## Application Built

### Flutter Settings App (`settings_prefs_demo`)

A single Settings screen demonstrating every SharedPreferences requirement from the task, backed entirely by one `SharedPreferences` instance.

## Features

* Theme toggle (light/dark), applied immediately and persisted
* Language dropdown with a "Remove Language Preference" action
* Favorite-languages selector (`List<String>` example)
* Notification toggle
* Remember-login toggle
* Font size slider (`double` example)
* First-launch flag, shown on screen
* Login/open count, incremented on every app start (proves persistence survives a full restart, not just a hot reload)
* "Clear All Preferences" button that wipes storage and reloads defaults

The Settings screen loads all values once in `initState`, and `main.dart` reads the theme value *before* building `MaterialApp` so there's no flash of the wrong theme on startup.

## Concepts Learned

### `SharedPreferences.getInstance()`

Always `async` — must be awaited before any read or write. Called fresh in each method here rather than cached, since Flutter internally caches the singleton anyway.

### Default values / null handling

Every read follows the same pattern:

```dart
final language = prefs.getString('language') ?? 'English';
```

A key that has never been written returns `null`, not an exception — the `??` fallback is what makes "first run" behave sanely.

### `remove()` vs `clear()`

```dart
await prefs.remove('language'); // one key only
await prefs.clear();            // everything
```

After either call, the next `get*` call returns `null` again, so the same default-value pattern applies automatically — no separate "reset" logic needed for the data itself.

### When to use SharedPreferences vs a database

SharedPreferences fits flat, one-off values — settings, flags, a single selected value. Multiple records of the same shape, relationships between data, or queries (filter/sort/join) are a sign to use SQLite/Floor instead (Day 12/13), not SharedPreferences.

## Important Issue Encountered

Turning on Dark Mode and then tapping **Clear All Preferences** reset the toggle switch back to off, but the screen's actual background stayed dark.

Root cause: the reload method after `clear()` only updated the Settings screen's own local state. It never called the `onThemeChanged` callback that the *parent* app (`main.dart`, which owns `MaterialApp`'s `themeMode`) depends on. `_setDarkMode()` called that callback correctly when the switch was tapped directly — the reload path after `clear()` (and on initial app load) did not.

Fix: `_loadAllPreferences()` now also calls `widget.onThemeChanged(_isDarkMode)` after reading the stored value, so the parent's actual theme always matches what was just loaded — on both cold start and after `clear()`.

This demonstrated an important SharedPreferences pattern: reading a value back from storage and updating local widget state is not the same as propagating that value to whatever else in the widget tree depends on it. A callback (or shared state solution) has to be called explicitly on every path that changes the value, not just the "obvious" one.

## Current Verification Status

The fix for the dark-mode/clear-all bug has been made but **not yet re-verified** end-to-end. The implementation should therefore not yet be reported as fully tested.

## Final Verification Checklist

Before marking Day 14 as fully completed:

* [ ] Run `flutter pub get`
* [ ] Fully stop and restart the app (not hot reload)
* [ ] Set theme, language, notifications, login, font size
* [ ] Fully stop and restart again — confirm every value survived
* [ ] Confirm login/open count increased by exactly 1 per restart
* [ ] Tap **Remove Language Preference** — confirm language resets to English, nothing else changes
* [ ] Tap **Clear All Preferences** while Dark Mode is on — confirm the *background*, not just the switch, returns to light
* [ ] Confirm `isFirstLaunch` reads `true` again immediately after clearing
* [ ] Re-check favorite languages, font size, and notifications all return to defaults after clear

## Screenshots

### Light mode

<img width="338" height="727" alt="image" src="https://github.com/user-attachments/assets/709d9d2a-17ba-40cb-9f36-c8ca6d0a3817" />

### Dark mode

<img width="349" height="754" alt="image" src="https://github.com/user-attachments/assets/0eaf0214-3e71-49a2-9b1b-fca6926a5303" />

### Clearing all preferences

<img width="336" height="735" alt="image" src="https://github.com/user-attachments/assets/b69346d8-b269-4002-9eae-586f6c620134" />


## Repository Structure

```text
Day 14/
│
├── settings_prefs_demo/
│   ├── lib/
│   │   ├── main.dart
│   │   └── settings_screen.dart
│   ├── pubspec.yaml
│   └── README.md
└── README.md
```

## Resources

SharedPreferences Package Documentation:

https://pub.dev/packages/shared_preferences

## YouTube Search Terms

* Flutter SharedPreferences
* Flutter local storage
* Save data locally Flutter
* App settings Flutter
* Remember login Flutter

## Recommended Channels

* The Flutter Way
* Flutter Explained
* Reso Coder

## Conclusion

Day 14 provided practical experience with SharedPreferences as Flutter's key-value local storage solution, covering all five supported data types, default/null handling, single-key removal vs full clearing, and applying persisted settings on restart.

The module also surfaced a real bug worth remembering: updating local widget state after reading from storage does not automatically propagate that value to a parent widget's own state. Any path that reloads a persisted value — not just the direct user-triggered change — needs to explicitly call whatever callback keeps the rest of the app in sync. Final end-to-end testing remains pending until the checklist above passes.
