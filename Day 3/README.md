# Day 3 – Flutter & Git Fundamentals

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

**Profile Screen**
<img width="406" height="877" alt="image" src="https://github.com/user-attachments/assets/b579507e-7094-4a8f-80a6-ac7993bf07dd" />

**Form Screen**
<img width="408" height="878" alt="image" src="https://github.com/user-attachments/assets/28ef2b9a-9d6e-4587-8728-92d8092f6d10" />

**List Screen**
<img width="410" height="874" alt="image" src="https://github.com/user-attachments/assets/87d63dcd-ff0a-4daf-abdd-399b408df121" />

**GitHub commit history**

![commits](<img width="1884" height="390" alt="image" src="https://github.com/user-attachments/assets/6ee94c4c-e0f7-45fa-8399-6031b0a21b05" />
)

## Files
See `Day X/flutter_learning/` for the full project (`lib/main.dart`, 
`lib/screens/`, `lib/widgets/`).
