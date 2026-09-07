# Day 4 - Flutter Layout Practice

# What I did
Built a 6-screen Flutter practice app covering core layout widgets, from constraints through complex responsive UIs, and pushed it to GitHub under the Linkific Tasks repo (Day 4).

## Concepts covered

**Git Version Control** — Moved the project into the existing "Linkific Tasks" repo under a Day 4 folder, staged and committed changes with descriptive messages, and pushed to GitHub.

**Widget Tree & Constraints** — Practiced how Flutter widgets pass constraints down and sizes back up, and how `Row`/`Column` distribute space among children.

**StatelessWidget** — All 6 screens built as StatelessWidget, since none required dynamic state — content is static per screen.

**Core & Layout Widgets** — Applied `MaterialApp`/`Scaffold`, `AppBar`, `Row`/`Column`, `Padding`, `Expanded`, `Flexible`, `SafeArea`, `CircleAvatar`, and `Image.network` across the screens.

**ListView.builder & ListView.separated** — Built a WhatsApp-style chat screen rendering 100+ messages efficiently using `itemBuilder`, plus a second `ListView.separated` section to compare automatic divider insertion against plain `.builder`.

**GridView.builder & GridView.count** — Built a responsive e-commerce product grid using `SliverGridDelegateWithFixedCrossAxisCount`, plus a `GridView.count` section for comparison on a small fixed set of items.

**Stack, Positioned & StackFit** — Built a layered UI (avatar with badge overlay) using `Positioned` for absolute placement, and `StackFit.expand` to make non-positioned children fill a bounded Stack area.

**Expanded vs Flexible** — Built a dedicated comparison screen showing `Expanded` (forces child to fill space, `FlexFit.tight`) against `Flexible` (child can be smaller than its allotted space, `FlexFit.loose`), with `flex` factors controlling the 1:2 space ratio between siblings.

**Navigation** — Implemented `Navigator.push`/`MaterialPageRoute` from a home menu screen to each of the 6 practice screens.

## Learning approach
Followed the assigned plan: layout fundamentals and constraints → Row/Column → Expanded/Flexible → Stack → ListView → GridView → applied each concept directly into a working screen rather than isolated exercises. Debugged real errors along the way — including a `Navigator` context scoping issue (calling `Navigator.push` with a context above the Navigator in the widget tree) — which clarified how `BuildContext` and widget tree position actually work.

## Screens

1. **Instagram Post Card** — Row/Column, Expanded, nested layouts
<img width="305" height="670" alt="image" src="https://github.com/user-attachments/assets/ab06287d-684d-4b75-a669-cde8bdd0d496" />

2. **WhatsApp Chat** — ListView.builder (100+ items) and ListView.separated
<img width="307" height="673" alt="image" src="https://github.com/user-attachments/assets/f0b903e3-290f-4607-91dc-7aaed0e29d74" />

3. **E-commerce Product Grid** — GridView.builder and GridView.count
<img width="300" height="666" alt="image" src="https://github.com/user-attachments/assets/8c5cb8e2-bb65-4885-a20d-f133e4c75776" />

4. **Settings Page** — ListView with ListTile, grouped items
<img width="300" height="660" alt="image" src="https://github.com/user-attachments/assets/1baec8a8-12c3-421d-9c40-e606648ef67e" />

5. **Stack Demo** — Stack, Positioned, StackFit.expand
<img width="301" height="657" alt="image" src="https://github.com/user-attachments/assets/59da1d08-93ed-436b-8955-893a8fc7a975" />

6. **Flex Demo** — Expanded vs Flexible, flex factors
*(add screenshot link once uploaded)*

## Widgets & Patterns

### Row / Column
Used for horizontal/vertical arrangement of widgets. `crossAxisAlignment` and `mainAxisAlignment` control positioning within available space.

### Expanded vs Flexible
`Expanded` is `Flexible` with `FlexFit.tight` — forces the child to fill its allotted space. Plain `Flexible` uses `FlexFit.loose` — the child can be smaller than its allotted space if it doesn't need it all. `flex` factor sets the ratio of space distribution between siblings (e.g. flex: 1 vs flex: 2 = 1:2 split).

### ListView.builder vs ListView.separated
`.builder` lazily builds only visible items — used for the 100+ item chat list, critical for performance. `.separated` works the same way but automatically inserts a separator widget between items.

### GridView.builder vs GridView.count
`.builder` is lazy-loaded, suited for large/dynamic item counts. `.count` builds all children immediately — simpler, but only suited for small, fixed-size grids.

### Stack / Positioned / StackFit
`Stack` layers widgets on top of each other; `Positioned` places a child at exact coordinates within the Stack. `StackFit.expand` makes non-positioned children fill the full bounded Stack area.

### SafeArea
Wraps screen content to avoid overlapping the device status bar / notch.
