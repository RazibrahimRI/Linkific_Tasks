# Day 8 - Flutter Navigation

## Overview

Day 8 focused on Flutter navigation patterns, using Navigator, named routes, nested navigators, drawer navigation, and bottom navigation to build a single interactive app.

The module covered basic navigation (push/pop, data passing), named routes, navigation drawers, bottom navigation with state persistence, TabBar/TabController, and nested navigation using multiple navigators.

## Learning Objectives

- Master navigation patterns
- Implement complex routing
- Handle navigation data
- Create navigation drawers

## Topics Covered

### Basic Navigation

- Navigator.push and pop
- MaterialPageRoute
- Passing data forward
- Returning data backward

### Named Routes

- Navigate with route names
- Pass arguments to named routes
- Extract route arguments

### Navigation Drawer

- Drawer widget
- DrawerHeader
- Navigation items
- Handle drawer taps

### Bottom Navigation

- BottomNavigationBar
- Multiple screens
- State persistence
- Icons and labels

### TabBar

- TabBar and TabBarView
- TabController
- Custom tab indicators

### Nested Navigation

- Multiple navigators
- Nested routes
- Bottom nav with tabs

# Application Built

## Navigation Demo App

A single app built to demonstrate the full set of navigation patterns above, rather than separate apps per concept.

### Features

* Bottom navigation with 3 tabs (Home, Profile, Settings)
* State persistence across tab switches (via IndexedStack)
* Navigation drawer with DrawerHeader and 4 items (Home, Profile, Settings, Details)
* Details screen with data passed forward (from Home and from Drawer) and returned backward on pop
* Named route navigation with argument passing and extraction
* Nested navigators — each bottom nav tab keeps its own independent navigation stack
* TabBar (All / Favorites / Recent) with custom tab indicator, inside the Home tab

### Concepts

* Navigator.push / pop, MaterialPageRoute
* Passing and returning data between screens
* Named routes, route arguments
* Drawer, DrawerHeader, tap handling
* BottomNavigationBar, IndexedStack for state persistence
* TabBar, TabBarView, DefaultTabController, custom indicator
* Nested Navigator widgets (one per tab) via GlobalKey<NavigatorState>

# Key Learning

The main learning from Day 8 was understanding how Flutter's different navigation systems (named routes, nested per-tab navigators, drawer, bottom nav, tabs) interact — and where they don't combine automatically.

Named routes are normally defined on MaterialApp's top-level route table, but nested navigators (one per bottom nav tab) each need their own route handling — the two don't compose for free. In this app, the Home tab's route to Details is resolved through its own nested Navigator rather than MaterialApp's route table, and the Drawer's route to Details goes through the root Navigator directly rather than by route name, since it's a separate entry point outside any tab's nested stack.

This meant deciding, screen by screen, which Navigator a given push should go through, and what that means for whether the bottom nav bar stays visible during navigation.

# Screenshots

## Home Tab - Bottom Nav + TabBar

<img width="307" height="686" alt="image" src="https://github.com/user-attachments/assets/5cd18a28-ab36-4ac9-8259-fe1c61ec8114" />

## Drawer

<img width="313" height="672" alt="image" src="https://github.com/user-attachments/assets/74c442db-bab9-4b58-bee1-458135950bf8" />

## Details Screen - Data Passed Forward/Back

<img width="303" height="676" alt="image" src="https://github.com/user-attachments/assets/a0ff9b65-7bda-4379-9b4c-d65b1f86f827" />

# Repository Structure

```text
Day 8/
│
├── navigation_demo_app/
└── README.md
```

# Resources

Flutter Navigation Documentation:

[https://docs.flutter.dev/cookbook/navigation](https://docs.flutter.dev/cookbook/navigation)

## YouTube Search Terms

* Flutter navigation complete guide
* Flutter routing tutorial
* Named routes Flutter
* Flutter navigation drawer
* Bottom navigation bar Flutter

## Recommended Channels

* Flutter Official
* Reso Coder
* The Flutter Way

# Conclusion

Day 8 provided practical experience with Flutter navigation and routing. Building a single app that combines named routes, drawer navigation, bottom navigation with persisted state, nested navigators, and TabBar/TabController reinforced how these systems work individually and where they require deliberate decisions to work together correctly.
