# Day 13 - Flutter Floor Database

## Overview

Day 13 focused on using **Floor** as an ORM-based SQLite database solution in Flutter. The existing sqflite Notes app was migrated to Floor to understand how Floor simplifies database access through entities, DAOs, annotations, generated code, and reactive streams.

The module covered Floor database setup, entity and primary key configuration, DAO-based CRUD operations, `Stream` queries, column mapping, foreign key relationships, category management, and database migrations.

The existing Notes app was used as the main application so that the Floor implementation could be compared with the previous sqflite-based version.

## Learning Objectives

* Understand Floor database setup in Flutter
* Create Floor entities and configure primary keys
* Create DAOs for database operations
* Perform CRUD operations using Floor annotations
* Use reactive `Stream` queries
* Configure column names and foreign key relationships
* Implement database migrations
* Compare Floor with the previous sqflite implementation

## Topics Covered

### Floor Database Setup

* Floor package
* `FloorDatabase`
* `@Database`
* Database versioning
* `databaseBuilder()`
* Generated database code using `build_runner`
* `app_database.g.dart`
* Adding migrations to the database builder

### Entity Design

* `@Entity`
* `@PrimaryKey`
* `@PrimaryKey(autoGenerate: true)`
* Nullable auto-generated primary keys
* `@ColumnInfo`
* Custom database column names
* Entity relationships

The `Note` entity uses an auto-generated primary key and maps its Dart fields to SQLite column names using `@ColumnInfo`. The `Category` entity also uses an auto-generated primary key and maps its name field to `category_name`.

### DAO Operations

Created `NoteDao` with:

* `findAllNotesOnce()`
* `watchAllNotes()`
* `insertNote()`
* `updateNote()`
* `deleteNote()`

Floor annotations used:

* `@Query`
* `@insert`
* `@update`
* `@delete`

The notes list is queried using:

```sql
SELECT * FROM note ORDER BY created_at DESC
```

and the reactive version returns:

```dart
Stream<List<Note>>
```

### Category DAO and CRUD

The previous Category DAO only provided category reading. It was expanded to provide full CRUD:

* `findAllCategoriesOnce()`
* `watchAllCategories()`
* `insertCategory()`
* `updateCategory()`
* `deleteCategory()`

This allows categories to be created, renamed, deleted, and observed through a reactive stream.

### Foreign Key Relationship

The `Note` entity was configured with a relationship to `Category`.

The relationship uses:

```dart
ForeignKey(
  childColumns: ['category_id'],
  parentColumns: ['id'],
  entity: Category,
  onDelete: ForeignKeyAction.setNull,
)
```

An index was also added for `category_id`.

The `setNull` behavior means that deleting a category clears the corresponding `category_id` from its notes instead of deleting the notes themselves.

### Database Migration

A version 1 → version 2 migration was implemented.

The migration:

* Creates the `Category` table
* Adds `category_id` to the existing `note` table
* Creates an index for `category_id`
* Changes the database version from `1` to `2`

The migration is registered when building the database:

```dart
.addMigrations([migration1to2])
```

## Application Built

### Flutter Floor Notes App

The existing SQLite Notes app was migrated from direct sqflite database operations to Floor.

The application continues to use a Notes and Categories structure while database operations are handled through Floor entities and DAOs.

## Features

* Home screen displaying notes
* Search notes by title or content
* Swipe-to-delete notes
* Add and edit notes
* Category dropdown when creating or editing a note
* Add new categories
* Rename categories
* Delete categories
* Notes associated with categories through a foreign key
* Notes ordered by creation time
* Reactive note list using `StreamBuilder`
* Reactive category list using `StreamBuilder`
* Automatic list updates after database changes
* Database migration from version 1 to version 2

The Home screen uses `watchAllNotes()` as the source of the notes list, while search filtering is performed on the emitted list. Swipe-to-delete calls the Floor DAO's `deleteNote()` method.

## Concepts Learned

### `@PrimaryKey(autoGenerate: true)`

The primary key must explicitly use:

```dart
@PrimaryKey(autoGenerate: true)
final int? id;
```

A bare primary-key annotation does not explicitly configure Floor's auto-generation behavior.

### `@ColumnInfo`

`@ColumnInfo` allows the Dart property name and database column name to be specified separately.

Examples:

```dart
@ColumnInfo(name: 'category_name')
final String name;
```

and:

```dart
@ColumnInfo(name: 'category_id')
final int? categoryId;
```

### DAO Pattern

Instead of writing database operations directly throughout the application, Floor organizes database access into DAO classes.

For example:

```dart
@insert
Future<int> insertNote(Note note);
```

```dart
@update
Future<int> updateNote(Note note);
```

```dart
@delete
Future<int> deleteNote(Note note);
```

This separates database operations from the UI code.

### Reactive Database Updates

`Stream<List<Note>>` was used so the Home screen can react automatically to database changes.

The Home screen uses:

```dart
StreamBuilder<List<Note>>(
  stream: widget.database.noteDao.watchAllNotes(),
)
```

Because of this, the app does not need to manually reload the notes after returning from the Add/Edit screen.

### Category Management

A separate Category management screen was added to close the previous CRUD gap.

It supports:

* Adding categories
* Renaming categories
* Deleting categories
* Displaying categories using a reactive stream

## Floor vs sqflite

The previous Day 12 implementation used sqflite directly, where database operations were manually performed through methods such as `insert`, `query`, `update`, `delete`, and `rawQuery`.

The Floor implementation instead uses:

* Entities
* DAOs
* Annotations
* Generated database code
* Typed Dart models
* Reactive query streams
* Migration definitions

This provided practical experience with the ORM-style approach to SQLite database development in Flutter.

## Important Issue Encountered

After adding the `@delete` method to `NoteDao`, the generated database file became out of sync with the DAO interface.

The generated `_$NoteDao` class did not initially contain the implementation for:

```dart
deleteNote(Note note)
```

This demonstrated that Floor's generated code must be regenerated after changing database entities or DAO definitions.

The required command is:

```bash
dart run build_runner build --delete-conflicting-outputs
```

After code generation, the application should be fully stopped and started again rather than relying only on hot restart.

## Current Verification Status

The Floor implementation has been written, including:

* Auto-generated note IDs
* `Stream<List<Note>>`
* Note `@delete`
* `@ColumnInfo`
* Note → Category foreign key
* Category CRUD
* Category management UI
* Version 1 → 2 migration
* Stream-driven Home screen

However, the final end-to-end verification is **still pending** because the current generated `app_database.g.dart` is producing a `sqflite` import/prefix error during restart.

The implementation should therefore not yet be reported as fully tested.

## Final Verification Checklist

Before marking Day 13 as fully completed:

* [ ] Run `flutter clean`
* [ ] Run `flutter pub get`
* [ ] Regenerate Floor code using `build_runner`
* [ ] Fully stop and restart the application
* [ ] Confirm the project compiles successfully
* [ ] Add a note and confirm its generated ID
* [ ] Close and reopen the app and confirm the note persists
* [ ] Test note search
* [ ] Test swipe-to-delete
* [ ] Add a category
* [ ] Rename a category
* [ ] Delete a category
* [ ] Confirm deleting a category sets its notes' `category_id` to null
* [ ] Add/edit a note and confirm the list updates automatically through the stream

## Screenshots

## Home Screen — Floor Notes list with search

<img width="337" height="755" alt="image" src="https://github.com/user-attachments/assets/730b9723-7e67-4a00-b8ca-10c9632f6321" />


## Add/Edit Note — Category dropdown

<img width="332" height="765" alt="image" src="https://github.com/user-attachments/assets/683fbcd8-8015-4018-8e4d-4a5bef705bca" />

## Category Management — Add, rename and delete categories

<img width="335" height="734" alt="image" src="https://github.com/user-attachments/assets/fec162a3-d662-4672-b571-862648c914d7" />


## Notes List — Reactive stream updates

<img width="335" height="732" alt="image" src="https://github.com/user-attachments/assets/c0c1f426-ca68-451d-81c8-66ffb4084acc" />


## Repository Structure

```text
Day 13/
│
├── flutter_floor_notes/
│   ├── lib/
│   │   ├── main.dart
│   │   ├── app_database.dart
│   │   ├── note.dart
│   │   └── category.dart
│   │   ├── note_dao.dart
│   │   └── category_dao.dart
│   │   └── screens/
│   │       ├── home_screen.dart
│   │       ├── add_edit_note_screen.dart
│   │       └── add_edit_category_screen.dart
│   ├── pubspec.yaml
│   └── README.md
└── README.md
```

## Resources

Floor Package Documentation:

https://pub.dev/packages/floor

## YouTube Search Terms

* Flutter Floor database
* Floor vs sqflite
* Flutter database patterns
* Flutter Floor complete tutorial
* Floor ORM Flutter

## Recommended Channels

* Reso Coder
* Flutter Explained

## Conclusion

Day 13 provided practical experience migrating a Flutter SQLite application from sqflite to Floor.

The Notes app was used to implement Floor entities, DAOs, CRUD operations, reactive streams, column mappings, foreign key relationships, category management, and database migrations.

The migration also demonstrated an important part of working with Floor: database and DAO changes require generated code to be regenerated using `build_runner`. The final application testing remains pending until the current generated-code `sqflite` import issue is resolved and the complete verification checklist passes.
