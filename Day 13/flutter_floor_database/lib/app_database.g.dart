// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NoteDao? _noteDaoInstance;

  CategoryDao? _categoryDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `note` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `content` TEXT NOT NULL, `category_id` INTEGER, `created_at` INTEGER NOT NULL, FOREIGN KEY (`category_id`) REFERENCES `Category` (`id`) ON UPDATE NO ACTION ON DELETE SET NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Category` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `category_name` TEXT NOT NULL)');
        await database.execute(
            'CREATE INDEX `index_note_category_id` ON `note` (`category_id`)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NoteDao get noteDao {
    return _noteDaoInstance ??= _$NoteDao(database, changeListener);
  }

  @override
  CategoryDao get categoryDao {
    return _categoryDaoInstance ??= _$CategoryDao(database, changeListener);
  }
}

class _$NoteDao extends NoteDao {
  _$NoteDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _noteInsertionAdapter = InsertionAdapter(
            database,
            'note',
            (Note item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'content': item.content,
                  'category_id': item.categoryId,
                  'created_at': item.createdAt
                },
            changeListener),
        _noteUpdateAdapter = UpdateAdapter(
            database,
            'note',
            ['id'],
            (Note item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'content': item.content,
                  'category_id': item.categoryId,
                  'created_at': item.createdAt
                },
            changeListener),
        _noteDeletionAdapter = DeletionAdapter(
            database,
            'note',
            ['id'],
            (Note item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'content': item.content,
                  'category_id': item.categoryId,
                  'created_at': item.createdAt
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Note> _noteInsertionAdapter;

  final UpdateAdapter<Note> _noteUpdateAdapter;

  final DeletionAdapter<Note> _noteDeletionAdapter;

  @override
  Future<List<Note>> findAllNotesOnce() async {
    return _queryAdapter.queryList(
        'SELECT * FROM note ORDER BY created_at DESC',
        mapper: (Map<String, Object?> row) => Note(
            id: row['id'] as int?,
            title: row['title'] as String,
            content: row['content'] as String,
            categoryId: row['category_id'] as int?,
            createdAt: row['created_at'] as int));
  }

  @override
  Stream<List<Note>> watchAllNotes() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM note ORDER BY created_at DESC',
        mapper: (Map<String, Object?> row) => Note(
            id: row['id'] as int?,
            title: row['title'] as String,
            content: row['content'] as String,
            categoryId: row['category_id'] as int?,
            createdAt: row['created_at'] as int),
        queryableName: 'note',
        isView: false);
  }

  @override
  Future<int> insertNote(Note note) {
    return _noteInsertionAdapter.insertAndReturnId(
        note, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateNote(Note note) {
    return _noteUpdateAdapter.updateAndReturnChangedRows(
        note, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteNote(Note note) {
    return _noteDeletionAdapter.deleteAndReturnChangedRows(note);
  }
}

class _$CategoryDao extends CategoryDao {
  _$CategoryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _categoryInsertionAdapter = InsertionAdapter(
            database,
            'Category',
            (Category item) =>
                <String, Object?>{'id': item.id, 'category_name': item.name},
            changeListener),
        _categoryUpdateAdapter = UpdateAdapter(
            database,
            'Category',
            ['id'],
            (Category item) =>
                <String, Object?>{'id': item.id, 'category_name': item.name},
            changeListener),
        _categoryDeletionAdapter = DeletionAdapter(
            database,
            'Category',
            ['id'],
            (Category item) =>
                <String, Object?>{'id': item.id, 'category_name': item.name},
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Category> _categoryInsertionAdapter;

  final UpdateAdapter<Category> _categoryUpdateAdapter;

  final DeletionAdapter<Category> _categoryDeletionAdapter;

  @override
  Future<List<Category>> findAllCategoriesOnce() async {
    return _queryAdapter.queryList(
        'SELECT * FROM Category ORDER BY category_name ASC',
        mapper: (Map<String, Object?> row) => Category(
            id: row['id'] as int?, name: row['category_name'] as String));
  }

  @override
  Stream<List<Category>> watchAllCategories() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Category ORDER BY category_name ASC',
        mapper: (Map<String, Object?> row) => Category(
            id: row['id'] as int?, name: row['category_name'] as String),
        queryableName: 'Category',
        isView: false);
  }

  @override
  Future<int> insertCategory(Category category) {
    return _categoryInsertionAdapter.insertAndReturnId(
        category, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateCategory(Category category) {
    return _categoryUpdateAdapter.updateAndReturnChangedRows(
        category, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteCategory(Category category) {
    return _categoryDeletionAdapter.deleteAndReturnChangedRows(category);
  }
}
