# Day 4 - Flutter Layout Practice

# What I did

Built a 5-screen Flutter practice app covering core layout widgets, from constraints through complex responsive UIs, and pushed it to GitHub under the Linkific Tasks repo (Day 4).

## Concepts covered

**Git Version Control** — Moved the project into the existing "Linkific Tasks" repo under a Day 4 folder, staged and committed changes with descriptive messages, and pushed to GitHub.

**Widget Tree & Constraints** — Practiced how Flutter widgets pass constraints down and sizes back up, and how `Row`/`Column` distribute space among children.

**StatelessWidget** — All 5 screens built as StatelessWidget, since none required dynamic state — content is static per screen.

**Core & Layout Widgets** — Applied `MaterialApp`/`Scaffold`, `AppBar`, `Row`/`Column`, `Padding`, `Expanded`, `SafeArea`, `CircleAvatar`, and `Image.network` across the screens.

**ListView.builder** — Built a WhatsApp-style chat screen rendering 100+ messages efficiently, using `itemBuilder` instead of hardcoding widgets, to avoid building all items at once.

**GridView.builder** — Built a responsive e-commerce product grid using `SliverGridDelegateWithFixedCrossAxisCount`.

**Stack & Positioned** — Built a layered UI (avatar with badge overlay) to practice absolute positioning within a bounded area.

**Navigation** — Implemented `Navigator.push`/`MaterialPageRoute` from a home menu screen to each of the 5 practice screens.

## Learning approach

Followed the assigned plan: layout fundamentals and constraints → Row/Column → Expanded/Flexible → Stack → ListView → GridView → applied each concept directly into a working screen rather than isolated exercises. Debugged real errors along the way — including a `Navigator` context scoping issue (calling `Navigator.push` with a context above the Navigator in the widget tree) — which clarified how `BuildContext` and widget tree position actually work.

## Screens

1. **Instagram Post Card** — Row/Column, Expanded, nested layouts

<img width="305" height="670" alt="image" src="https://github.com/user-attachments/assets/ab06287d-684d-4b75-a669-cde8bdd0d496" />

2. **WhatsApp Chat** — ListView.builder with 100+ items (performance)

<img width="307" height="673" alt="image" src="https://github.com/user-attachments/assets/f0b903e3-290f-4607-91dc-7aaed0e29d74" />

3. **E-commerce Product Grid** — GridView.builder, responsive columns

<img width="300" height="666" alt="image" src="https://github.com/user-attachments/assets/8c5cb8e2-bb65-4885-a20d-f133e4c75776" />

4. **Settings Page** — ListView with ListTile, grouped items

<img width="300" height="660" alt="image" src="https://github.com/user-attachments/assets/1baec8a8-12c3-421d-9c40-e606648ef67e" />

5. **Stack Demo** — Stack, Positioned, layered UI elements

<img width="301" height="657" alt="image" src="https://github.com/user-attachments/assets/59da1d08-93ed-436b-8955-893a8fc7a975" />

## Widgets & Patterns

### Row / Column
Used for horizontal/vertical arrangement of widgets. `crossAxisAlignment` and `mainAxisAlignment` control positioning within available space.

### Expanded / Flexible
`Expanded` forces a child to fill remaining space in a Row/Column. Used in the Instagram header to push the username to take available width while keeping the menu icon fixed.

### ListView.builder
Used instead of a plain `ListView` with hardcoded children — only builds visible items as the user scrolls, rather than all 100+ at once. Critical for performance with large lists.

### GridView.builder
Renders items in a grid using `SliverGridDelegateWithFixedCrossAxisCount`, with a fixed column count and spacing for a responsive product grid layout.

### Stack / Positioned
Used to layer widgets on top of each other — e.g. a badge icon positioned over a profile avatar. `Positioned` controls exact placement within the Stack's bounds.

### SafeArea
Wraps screen content to avoid overlapping the device status bar / notch.
