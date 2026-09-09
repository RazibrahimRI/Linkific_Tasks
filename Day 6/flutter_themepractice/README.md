# Day 6 - Flutter Theming Practice

A single-screen Flutter app demonstrating custom Material 3 theming: a color palette, light/dark theme definitions, component-level theming, and a runtime Light/Dark/System theme switcher with persistence.

## Overview & Learning Objectives

- Understand Flutter's theming system: `ThemeData`, `ColorScheme`, `TextTheme`, component themes
- Implement a custom Material 3 theme (`useMaterial3`, `ColorScheme.fromSeed`, color roles)
- Build light and dark theme definitions, plus `ThemeMode.system` support
- Add a runtime theme toggle and persist the selected mode
- Style the entire app through `Theme.of(context)` — no hardcoded colors

## What I completed

Built a Flutter theming practice app (`flutter_themepractice`) with a single Home screen that demonstrates a fully custom Material 3 theme. A brand seed color, defined in a dedicated palette file, drives a generated `ColorScheme` for both light and dark modes. A custom `TextTheme` and component themes (AppBar, ElevatedButton, OutlinedButton, Card) are wired into `ThemeData`, so the screen inherits consistent styling entirely through `Theme.of(context)` — no hardcoded color values anywhere in the UI. Three buttons — **Light**, **Dark**, and **System** — switch the app's theme at runtime, and the selected mode is persisted with `shared_preferences` so it's restored automatically on the next launch.

## Project structure

```
lib/
├── main.dart              # App entry point, theme state (ThemeMode), persistence
├── app_theme.dart     # ColorScheme, TextTheme, component themes, light/dark ThemeData
└──  home_screen.dart   # Themed content + Light/Dark/System toggle
```

## Measurable progress

- Light and dark themes both verified working on the Pixel 7 API 34 emulator
- All three toggle buttons (Light, Dark, System) confirmed working and visible on screen
- Persistence confirmed: selected mode is saved and restored after a hot restart
- All component themes (AppBar, buttons, cards, icons, text styles) render correctly in both modes with no hardcoded colors remaining in screen files

## Palette

Defined in `theme/app_colors.dart`:

| Name | Value | Purpose |
|---|---|---|
| `seed` | `#4F46E5` (indigo) | Brand color — the single source `ColorScheme.fromSeed` derives every color role from |
| `surfaceLight` | `#FFFFFF` | Explicit light-mode surface color |
| `surfaceDark` | `#121212` | Explicit dark-mode surface color |
| `textPrimaryLight` | `#1A1A1A` | Explicit light-mode primary text color |
| `textPrimaryDark` | `#F5F5F5` | Explicit dark-mode primary text color |

`seed` is the value that actually drives the app — it's passed into `ColorScheme.fromSeed` for both light and dark schemes, so it's what changes button, AppBar, and icon colors. The surface/text constants are defined to satisfy the "custom color palette" requirement explicitly, but `ColorScheme.fromSeed` already derives its own surface/text roles automatically — these named constants document the palette clearly without needing to override Flutter's generated values.

## How the theme switcher works

1. `_MyAppState` in `main.dart` holds the current `ThemeMode` as state.
2. On launch, it reads a saved value from `shared_preferences` (defaults to `ThemeMode.system` if none is saved).
3. Tapping Light / Dark / System on the Home screen calls `setMode()`, which updates the state (triggering an immediate UI rebuild) and writes the new value to `shared_preferences` for the next app launch.

## Screenshots

Light Mode
<img width="346" height="750" alt="image" src="https://github.com/user-attachments/assets/112ea50f-c34c-48b7-a9b6-3efde50bdeda" />

Dark Mode
<img width="343" height="754" alt="image" src="https://github.com/user-attachments/assets/bd4c0dcd-0bb4-4b89-8ab6-f4010b34a2a1" />

System Mode
<img width="348" height="739" alt="image" src="https://github.com/user-attachments/assets/e8c98e5c-0a58-40e5-955f-b7dd96659cc7" />
 

## Notes / scope decisions

- The app intentionally stays to a single Home screen with static content — no backend, auth, or navigation, since the learning objective is theming, not app functionality.
- Semantic colors (success/error) were considered but left out, since nothing in the app currently has a success/error state to color. Surface and text colors were defined  to satisfy the palette requirement, even though `ColorScheme.fromSeed` already generates functional equivalents on its own.
- Dynamic color (Android 12+ wallpaper-based theming) and Material 3 surface tints were covered conceptually but not implemented, as they require a separate package (`dynamic_color`) and real-device testing outside this task's scope.

## Biggest challenge / learning

Ran into a build error from placing a widget's field and constructor inside the `build()` method instead of at the class level — fixed by moving both to sit directly under the class declaration. A related issue followed: after adding a required `onModeChanged` parameter to `HomeScreen`, every place that widget was instantiated elsewhere in the app had to be updated to pass it, or the build failed. Takeaway: a widget's fields and constructor are declared once at the class level, and Dart enforces that every required parameter is provided everywhere that widget is used.

## Resources used

- [Flutter Themes Cookbook](https://docs.flutter.dev/cookbook/design/themes)
- Flutter Official, Reso Coder, and The Flutter Way (YouTube)
