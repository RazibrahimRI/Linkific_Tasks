# Day X – Flutter & Git Fundamentals

## What I did
Set up Git version control for a Flutter project and built a 3-screen practice 
app covering core widget concepts, from the widget tree through navigation.

## Concepts covered

**Git Version Control** — Initialized a Git repo, connected it to GitHub, and 
configured a proper `.gitignore` to exclude build artifacts and secrets. Made 
incremental commits with clear messages (feat/fix/docs conventions) and 
practiced branching and merging for feature isolation.

**Widget Tree & Build Method** — Learned that Flutter apps are built entirely 
from widgets nested into a tree, and that the `build()` method describes the 
tree at any moment, re-run via hot reload whenever state changes.

**StatelessWidget vs StatefulWidget** — Built a Profile screen as a 
StatelessWidget (static content) and a Form screen as a StatefulWidget 
(updates via `setState()` as the user types and submits).

**Core & Layout Widgets** — Applied `MaterialApp`/`Scaffold`, `AppBar`, 
`Container`, `Row`/`Column`, `Padding`/`Center`, `ListView`, and `TextField` 
across the three screens.

**Navigation** — Implemented [bottom navigation bar / named routes] to move 
between the Profile, Form, and List screens without losing state.

**Reusable Widgets** — Split UI into custom components (`profile_card.dart`, 
`item_card.dart`) instead of building everything inline, for readability and 
reuse across screens.

## Learning approach
Followed a structured plan: Git basics → widget tree → StatelessWidget → 
StatefulWidget → core widgets → layout widgets → lists → navigation, then 
built a working 3-screen app applying each concept directly rather than 
treating them as separate exercises.

## Screenshots

| Profile Screen | Form Screen | List Screen |
|---|---|---|
| ![profile](screenshots/profile_screen.png) | ![form](screenshots/form_screen.png) | ![list](screenshots/list_screen.png) |

**GitHub commit history**

![commits](screenshots/commit_history.png)

## Files
See `Day X/flutter_learning/` for the full project (`lib/main.dart`, 
`lib/screens/`, `lib/widgets/`).
