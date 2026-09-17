import 'models_.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper {
  DatabaseHelper._internal();
  static final DatabaseHelper instance = DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbDirPath = await getDatabasesPath();
    final path = join(dbDirPath, 'notes_app.db');
    return openDatabase(
      path,
      version: 1,
      onConfigure: (db) async => db.execute('PRAGMA foreign_keys = ON'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE categories (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL UNIQUE
          )
        ''');
        await db.execute('''
          CREATE TABLE notes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            content TEXT NOT NULL,
            category_id INTEGER,
            created_at TEXT NOT NULL,
            FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE SET NULL
          )
        ''');
        for (final name in ['Personal', 'Work', 'Ideas']) {
          await db.insert('categories', {'name': name});
        }
      },
    );
  }

  // ---- categories ----
  Future<List<Category>> getAllCategories() async {
    final db = await database;
    final rows = await db.query('categories', orderBy: 'name ASC');
    return rows.map((r) => Category.fromMap(r)).toList();
  }

  // ---- create ----
  Future<int> insertNote(Note note) async {
    final db = await database;
    return db.insert('notes', note.toMap());
  }

  // ---- read ----
  Future<List<Note>> getNotesWithCategory({int? limit, int? offset}) async {
    final db = await database;
    final sql = '''
      SELECT n.id, n.title, n.content, n.category_id, n.created_at,
             c.name AS category_name
      FROM notes n
      LEFT JOIN categories c ON n.category_id = c.id
      ORDER BY n.created_at DESC
      ${limit != null ? 'LIMIT $limit' : ''}
      ${offset != null ? 'OFFSET $offset' : ''}
    ''';
    final rows = await db.rawQuery(sql);
    return rows.map((r) => Note.fromJoinedMap(r)).toList();
  }

  Future<List<Note>> searchNotes(String query) async {
    final db = await database;
    final rows = await db.query(
      'notes',
      where: 'title LIKE ? OR content LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'created_at DESC',
    );
    return rows.map((r) => Note.fromMap(r)).toList();
  }

  // ---- update ----
  Future<int> updateNote(Note note) async {
    final db = await database;
    return db.update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }

  // ---- delete ----
  Future<int> deleteNote(int id) async {
    final db = await database;
    return db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
