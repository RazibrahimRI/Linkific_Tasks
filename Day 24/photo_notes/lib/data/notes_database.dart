import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesDatabase {
  Database? _db;

  Future<Database> get _database async {
    _db ??= await openDatabase(
      join(await getDatabasesPath(), 'notes.db'),
      version: 1,
      onCreate: (db, version) => db.execute(
        'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, text TEXT NOT NULL)',
      ),
    );
    return _db!;
  }

  // SAFE: insert() sends the value separately from the SQL command.
  Future<void> addNote(String text) async {
    final db = await _database;
    await db.insert('notes', {'text': text});
  }

  Future<List<String>> getNotes() async {
    final db = await _database;
    final rows = await db.query('notes', orderBy: 'id DESC');
    return rows.map((row) => row['text'] as String).toList();
  }

}