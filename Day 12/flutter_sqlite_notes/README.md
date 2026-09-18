# Day 12 - Flutter SQLite

## Overview

Day 12 focused on local data persistence in Flutter using SQLite, covering how to set up a database, perform full CRUD operations, query data with filters and joins, and model relationships between tables using the sqflite package.

The module covered database initialization and path handling, designing tables with a foreign key relationship, implementing create/read/update/delete operations, and building a complete Notes app with search functionality and cross-restart persistence.

## Learning Objectives

- Setup SQLite in Flutter
- Perform CRUD operations
- Query the database
- Handle relationships between tables

## Topics Covered

### Database Setup

- sqflite and path packages
- getDatabasesPath() and path.join() for cross-platform file path resolution
- openDatabase() with version, onConfigure, and onCreate
- DatabaseHelper singleton pattern

### Table Design

- CREATE TABLE syntax
- Primary keys (INTEGER PRIMARY KEY AUTOINCREMENT)
- Foreign keys and ON DELETE behavior
- PRAGMA foreign_keys = ON (not enabled by default)

### CRUD Operations

- db.insert() — Create
- db.query() — Read (all rows, single row)
- db.update() — Update
- db.delete() — Delete
- Parameterized where/whereArgs (never string-concatenated SQL)

### Querying

- WHERE clauses and LIKE for search
- ORDER BY
- LIMIT / OFFSET for pagination
- JOIN queries via rawQuery()

## Application Built

### Flutter SQLite Notes App

A single Notes app built to demonstrate the full SQLite workflow above, rather than isolated examples per concept.

### Features

- Home screen with a note list, search bar, swipe-to-delete, and pull-to-refresh
- Add/Edit screen with title, content, and a category dropdown, sharing one form for both create and edit
- Notes persist across app restarts via an on-disk SQLite file
- Search filters notes by title or content using WHERE ... LIKE
- Notes are linked to categories via a foreign key, with default categories (Personal, Work, Ideas) seeded on first launch

### Concepts

- DatabaseHelper singleton — one shared database connection for the whole app
- toMap() / fromMap() — converting between Dart objects and SQLite rows
- fromJoinedMap() — a separate constructor for rows returned by a JOIN, which include an extra column not present on the base table
- LEFT JOIN vs INNER JOIN — LEFT JOIN keeps notes with no category assigned; INNER JOIN would silently drop them
- Why relationships and constraints in SQLite aren't automatic — foreign key enforcement has to be turned on explicitly

## Key Learning

The main learning from Day 12 was that SQLite does not enforce foreign key constraints by default — even with a FOREIGN KEY declared in the CREATE TABLE statement, SQLite will silently allow a note to be inserted with a category_id that doesn't exist in the categories table, unless PRAGMA foreign_keys = ON is explicitly set. This isn't a bug in the schema; it's SQLite's own default behavior, kept off for backward compatibility. The fix was setting the pragma inside onConfigure, which runs on every database connection open rather than just once on creation, so the constraint is enforced on every app launch, not only the first.

A second, smaller learning was the difference between LEFT JOIN and INNER JOIN in practice: an INNER JOIN version of the notes/categories query looked correct in testing until a note with no category was created, at which point it silently disappeared from the list. Switching to LEFT JOIN fixed it — a reminder that JOIN type isn't a stylistic choice, it changes which rows show up.

## Screenshots

## Home Screen — Notes list with search bar
<img width="345" height="754" alt="image" src="https://github.com/user-attachments/assets/9208df3d-e222-45b2-b781-bf34d50c2801" />


## Add/Edit Note screen with category dropdown
<img width="339" height="746" alt="image" src="https://github.com/user-attachments/assets/d22992d6-ada7-44f0-ab16-7e63f59950f5" />


## Note list showing category names after JOIN query
<img width="343" height="755" alt="image" src="https://github.com/user-attachments/assets/8dd8d379-939e-48fb-8c41-2d21ffdf51b4" />


## Repository Structure

```text
Day 12/
│
├── flutter_sqlite_notes/
│   ├── lib/
│   │   └── main.dart
│   │   └── database_.dart
│   │   └── models_.dart
│   │   └── screens/
│   │       └── home_screen.dart
│   │       └── addoredit_screen.dart      
│   ├── pubspec.yaml
│   └── README.md
└── README.md
```

## Resources

Flutter SQLite Package Documentation:

[https://pub.dev/packages/sqflite](https://pub.dev/packages/sqflite)

## YouTube Search Terms

* Flutter SQLite tutorial
* sqflite complete guide
* Flutter local database
* CRUD operations Flutter SQLite
* Database helper Flutter

## Recommended Channels

* Reso Coder
* The Flutter Way
* Johannes Milke

## Conclusion

Day 12 provided practical experience with local data persistence in Flutter using SQLite. Building a single Notes app that covers database setup, full CRUD, search, and a table relationship reinforced that a database layer isn't just "insert and select" — it surfaced concrete gotchas like foreign key enforcement being opt-in and JOIN type changing query results, both of which fail silently rather than throwing an error, so they only surface through deliberate testing.
