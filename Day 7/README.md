# Day 7 - Flutter State Management

## Overview

Day 7 focused on understanding state management in Flutter, using StatefulWidget and setState() to build interactive user interfaces.

The module covered local state, app-wide state, ephemeral state, StatefulWidget lifecycle, list state management, score/progress state management, and handling user interactions.

## Learning Objectives

- Understand state in Flutter
- Understand local vs app-wide state
- Understand ephemeral state
- Learn when to use setState()
- Master StatefulWidget
- Understand StatefulWidget lifecycle
- Handle user interactions
- Manage list state
- Manage score/progress state
- Build interactive Flutter applications

## Topics Covered

### State

- What is state?
- Local state
- App-wide state
- Ephemeral state
- When to use setState()

### StatefulWidget

- StatefulWidget
- State
- createState()
- initState()
- didUpdateWidget()
- dispose()

### setState()

Practiced using setState() to update state and rebuild the UI when values change.

Basic pattern:

````dart
setState(() {
  count++;
});
````

### User Interactions

Practiced handling:

* Button clicks
* Text input
* Checkboxes
* User selections
* Dynamic UI updates

## List State Management

Practiced:

* Adding items
* Removing items
* Updating items
* Toggling items
* Filtering items
* Searching items

## Score & Progress State Management

Practiced:

* Tracking selected answers
* Checking correctness
* Updating running score
* Progressing through questions
* Displaying results
* Resetting state

# Applications Built

## 1. Counter App

A simple application demonstrating basic state management with setState().

### Features

* Increment
* Decrement
* Reset
* Dynamic counter display

### Concepts

* StatefulWidget
* setState()
* Button interactions
* UI rebuilding

---

## 2. Todo List App

An interactive Todo application demonstrating dynamic list state management.

### Features

* Add todo
* Edit/update todo
* Delete todo
* Toggle completed status
* Search todos
* Filter todos

### Concepts

* List state
* CRUD operations
* setState()
* Searching
* Filtering
* User input

---

## 3. Calculator App

An interactive calculator demonstrating multiple state changes and user interactions.

### Features

* Number input
* Addition
* Subtraction
* Multiplication
* Division
* Clear
* Delete
* Equals
* Result display

### Concepts

* Button interactions
* Multiple state values
* setState()
* UI rebuilding
* Arithmetic operations
* State reset

---

## 4. Quiz App

An interactive quiz demonstrating score tracking and multi-question state management.

### Features

* Multiple-choice questions
* Answer selection
* Correctness checking
* Score tracking
* Visual right/wrong feedback
* Progress through questions
* Final results screen
* Restart quiz

### Concepts

* Multiple related state values
* setState()
* Conditional UI rendering
* Score calculation and reset

# Key Learning

The main learning from Day 7 was understanding how Flutter manages changing data and updates the UI using state.

State changes are reflected in the UI by calling setState() for local widget state.

The module also demonstrated how dynamic lists and multi-step interactive flows like a quiz can be managed as part of an interactive Flutter application.

# Screenshots

## Counter App

<img width="341" height="757" alt="Screenshot 2026-09-10 120925" src="https://github.com/user-attachments/assets/5e74447b-b4a0-4912-814b-3707c1c20ad7" />


## Todo App

<img width="322" height="736" alt="Screenshot 2026-09-10 130538" src="https://github.com/user-attachments/assets/1a419376-18aa-4c3c-903c-2323788f10b8" />


## Todo App - CRUD / Search / Filter

<img width="331" height="730" alt="Screenshot 2026-09-10 130546" src="https://github.com/user-attachments/assets/24d7a235-060e-4355-8bbc-362a8be34f76" />
<img width="333" height="727" alt="Screenshot 2026-09-10 130605" src="https://github.com/user-attachments/assets/a5e602db-0ee2-439b-b24f-42d2db08a5ae" />


## Calculator App

<img width="330" height="722" alt="Screenshot 2026-09-10 161950" src="https://github.com/user-attachments/assets/6f989926-8b96-4d78-90b0-6343843eb379" />

## Quiz App - Answering / Feedback

<img width="345" height="747" alt="Screenshot 2026-09-10 173959" src="https://github.com/user-attachments/assets/c64e29f5-92a0-47cb-ac84-be27ed88935f" />


## Quiz App - Results Screen

<img width="350" height="751" alt="Screenshot 2026-09-10 174015" src="https://github.com/user-attachments/assets/583f030a-2bd7-49e9-b6c1-a739c5fb2e67" />


# Repository Structure

````text
Day 7/
│
├── counter_app/
├── todo_app/
├── calculator_app/
├── quiz_app/
└── README.md
````

# Resources

Flutter State Management Documentation:

[https://docs.flutter.dev/data-and-backend/state-mgmt](https://docs.flutter.dev/data-and-backend/state-mgmt)

## YouTube Search Terms

* Flutter state management explained
* Flutter setState tutorial
* StatefulWidget complete guide
* Flutter interactive UI
* Flutter form state management

## Recommended Channels

* Reso Coder
* The Flutter Way
* Vandad Nahavandipoor

# Conclusion

Day 7 provided practical experience with Flutter state management and interactive UI development.

The four applications — Counter, Todo List, Calculator, and Quiz — helped reinforce StatefulWidget, setState(), lifecycle methods, list operations, score/progress tracking, and user interaction handling.
