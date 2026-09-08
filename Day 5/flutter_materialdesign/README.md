# Day 5 - Material Design Showcase App

A training exercise app built to practice Flutter's Material 3 widget catalog:
buttons, cards/lists, dialogs, feedback widgets, forms, and navigation.

## Material Design Concepts

Material Design is Google's design system — it defines consistent components
(buttons, cards, dialogs), spacing, elevation, and color rules so apps feel
coherent without custom-designing every widget from scratch.

## Material 3

Material 3 is the current default in Flutter (`useMaterial3: true` is on by
default in recent SDKs). It changes color roles (`ColorScheme.seed`),
typography scale, and component shapes compared to the older Material 2 look.

## Buttons

- `ElevatedButton` — primary action, filled background (Login)
- `TextButton` — low-emphasis action, no border/fill (secondary links)
- `OutlinedButton` — medium-emphasis action, bordered (Register, Form submit)
- `IconButton` — icon-only tap target (AppBar actions)
- `FloatingActionButton` — primary screen action, floats above content

## Cards and Lists

- `Card` — elevated container for grouped content (stat cards on Dashboard)
- `ListTile` — standard row layout with `leading`/`title`/`trailing`
- `Divider` — thin separator line between list items

## Dialogs

- `AlertDialog` — confirm/cancel a destructive action (delete project)
- `SimpleDialog` — pick one option from a list (theme choice)
- Custom `Dialog` — full control over layout when the two above don't fit
- `BottomSheet` (via `showModalBottomSheet`) — slide-up action menu

All dialogs are triggered through `showDialog()` / `showModalBottomSheet()`.

## SnackBars and Banner

- `SnackBar` — brief confirmation after an action (form submit), with an
  `UNDO` action button
- `MaterialBanner` — persistent, dismissible message at the top of the
  screen (shown once when Dashboard loads)

## Forms and Validation

- `TextField` — plain input, no validation (search box)
- `TextFormField` — input tied to a `Form`, supports `validator`
- `Form` + `GlobalKey<FormState>` — validates/resets all fields together
- `InputDecoration` — labels, borders, icons, error text

## Navigation

- Named routes (`/login`, `/register`, `/dashboard`, `/form`) defined via
  `onGenerateRoute` in `main.dart`
- `Navigator.pushNamed` / `Navigator.pop` for moving between screens
- Data passed between screens via route `arguments` (email from Login is
  read on Dashboard via `settings.arguments`)

## Widgets Used (10+)

ElevatedButton, TextButton, OutlinedButton, IconButton, FloatingActionButton,
Card, ListTile, Divider, AlertDialog, SimpleDialog, custom Dialog,
BottomSheet, SnackBar, MaterialBanner, TextField, TextFormField, Form.

## How to Run

```bash
flutter pub get
flutter run
```

Flow: Login → (Register optional) → Dashboard → Form.
