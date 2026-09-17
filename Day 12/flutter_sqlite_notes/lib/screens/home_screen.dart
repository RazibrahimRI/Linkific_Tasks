import 'package:flutter/material.dart';
import 'package:flutter_sqlite_notes/models_.dart';
import 'package:flutter_sqlite_notes/database_.dart';
import 'addoredit_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  List<Note> _notes = [];
  bool _loading = true;
  bool get _isSearching => _searchController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    setState(() => _loading = true);
    final notes = await DatabaseHelper.instance.getNotesWithCategory();
    setState(() {
      _notes = notes;
      _loading = false;
    });
  }

  Future<void> _runSearch(String query) async {
    if (query.trim().isEmpty) {
      _loadNotes();
      return;
    }
    setState(() => _loading = true);
    final results = await DatabaseHelper.instance.searchNotes(query.trim());
    setState(() {
      _notes = results;
      _loading = false;
    });
  }

  Future<void> _deleteNote(Note note) async {
    await DatabaseHelper.instance.deleteNote(note.id!);
    _isSearching ? _runSearch(_searchController.text) : _loadNotes();
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Deleted "${note.title}"')));
    }
  }

  Future<void> _openNote({Note? note}) async {
    final changed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => AddEditNoteScreen(note: note)),
    );
    if (changed == true) {
      _isSearching ? _runSearch(_searchController.text) : _loadNotes();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SQLite Notes')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search notes...',
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
                suffixIcon: _isSearching
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _loadNotes();
                  },
                )
                    : null,
              ),
              onChanged: _runSearch,
            ),
          ),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : _notes.isEmpty
                ? Center(
              child: Text(_isSearching ? 'No matching notes' : 'No notes yet'),
            )
                : RefreshIndicator(
              onRefresh: _loadNotes,
              child: ListView.builder(
                itemCount: _notes.length,
                itemBuilder: (context, index) {
                  final note = _notes[index];
                  return Dismissible(
                    key: ValueKey(note.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (_) => _deleteNote(note),
                    child: ListTile(
                      title:
                      Text(note.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                      subtitle: Text(note.content,
                          maxLines: 2, overflow: TextOverflow.ellipsis),
                      leading: CircleAvatar(
                        child: Text(note.categoryName?.substring(0, 1) ?? '-'),
                      ),
                      trailing: Text(
                        note.createdAt.substring(0, 10),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      onTap: () => _openNote(note: note),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openNote(),
        child: const Icon(Icons.add),
      ),
    );
  }
}