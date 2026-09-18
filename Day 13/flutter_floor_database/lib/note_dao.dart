import 'package:floor/floor.dart';
import '/note.dart';

@dao
abstract class NoteDao {
  @Query('SELECT * FROM note ORDER BY created_at DESC')
  Future<List<Note>> findAllNotesOnce();

  @Query('SELECT * FROM note ORDER BY created_at DESC')
  Stream<List<Note>> watchAllNotes();

  @insert
  Future<int> insertNote(Note note);

  @update
  Future<int> updateNote(Note note);

  @delete
  Future<int> deleteNote(Note note);
}