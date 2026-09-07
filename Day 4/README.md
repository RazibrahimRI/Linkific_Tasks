# Day 4 - Flutter Layout Practice

A single Flutter app demonstrating core layout widgets through 5 practice UIs.

## Screens

1. **Instagram Post Card** — Row/Column, Expanded, nested layouts
2. **WhatsApp Chat** — ListView.builder with 100+ items (performance)
3. **E-commerce Product Grid** — GridView.builder, responsive columns
4. **Settings Page** — ListView with ListTile, grouped items
5. **Stack Demo** — Stack, Positioned, layered UI elements

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
