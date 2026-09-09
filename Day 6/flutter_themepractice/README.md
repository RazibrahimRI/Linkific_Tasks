# Day 6 - Flutter Theming Practice

A small Flutter app demonstrating custom Material 3 theming: a color palette, light/dark theme definitions, component-level theming, and a runtime theme switcher with persistence.

## Objective

Learn and implement Flutter's theming system — `ThemeData`, `ColorScheme`, component themes, `Theme.of(context)`, light/dark modes, and persisting the user's theme choice.

## Project structure

```
lib/
├── main.dart              # App entry point, theme state (ThemeMode), persistence
├── theme/
│   ├── app_colors.dart    # Color palette (brand seed color)
│   └── app_theme.dart     # ColorScheme, TextTheme, component themes, light/dark ThemeData
└── screens/
    ├── home_screen.dart       # Sample content + Light/Dark/System toggle
    └── settings_screen.dart   # Secondary access point (nav bar)
```

## What was implemented

- **Custom `ThemeData`** for both light and dark modes (`AppTheme.light`, `AppTheme.dark`)
- **`ColorScheme`** generated from a single brand seed color via `ColorScheme.fromSeed`, giving consistent light/dark variants without manually defining every color role
- **`TextTheme`** — custom text styles that pull their color from the active `ColorScheme`, so typography adapts automatically between modes
- **Component themes**: `AppBarTheme`, `ElevatedButtonThemeData`, `OutlinedButtonThemeData`, `CardThemeData`
- **`Theme.of(context)`** used throughout the UI — no hardcoded `Colors.*` values in any screen
- **Three theme modes**: Light, Dark, and System (`ThemeMode.system`, which follows the device's OS-level setting)
- **Theme toggle**: buttons on the Home screen switch between modes at runtime
- **Persistence**: the selected mode is saved via `shared_preferences` and restored automatically on app restart
- **`useMaterial3: true`** enabled throughout

## Palette

Defined in `theme/app_colors.dart`:

| Name | Value | Purpose |
|---|---|---|
| `seed` | `#4F46E5` (indigo) | Brand color — the single source every `ColorScheme` role (primary, secondary, surface, etc.) is derived from |

Changing `seed` alone updates the color identity of the entire app (buttons, AppBar, icons) in both light and dark mode, without touching any screen file.

## How the theme switcher works

1. `_MyAppState` in `main.dart` holds the current `ThemeMode` as state.
2. On launch, it reads a saved value from `shared_preferences` (defaults to `ThemeMode.system` if none is saved).
3. Tapping Light/Dark/System on the Home screen calls `setMode()`, which updates the state (triggering an immediate UI rebuild) and writes the new value to `shared_preferences` for the next app launch.

## Notes / scope decisions

- Semantic colors (success/error) and explicit surface/text color constants were considered but left out, since nothing in the app currently uses them — `ColorScheme.fromSeed` already derives functional surface and text colors automatically.
- Dynamic color (Android 12+ wallpaper-based theming) and Material 3 surface tints were covered conceptually but not implemented, as they require a separate package (`dynamic_color`) and real-device testing outside this task's scope.
- The app intentionally stays to two screens (Home, Settings) with static content — no backend, auth, or data persistence beyond the theme preference itself, since the learning objective is theming, not app functionality.

## Resources used

- [Flutter Themes Cookbook](https://docs.flutter.dev/cookbook/design/themes)
- Flutter Official, Reso Coder, and The Flutter Way (YouTube)
