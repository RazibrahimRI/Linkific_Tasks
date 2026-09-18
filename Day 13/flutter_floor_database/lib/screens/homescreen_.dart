import 'package:flutter/material.dart';
import '/app_database.dart';
import '/note.dart';
import '/category.dart';
import 'addoredit_screen.dart';
import 'package:flutter_floor_database/screens/add_edit_category_screen.dart';

class HomeScreen extends StatefulWidget {
  final AppDatabase database;
  const HomeScreen({super.key, required this.database});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  Map<int, Category> _categoryMap = {};

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() => _query = _searchController.text.trim().toLowerCase());
    });
    _loadCategoryMap();
  }

  Future<void> _loadCategoryMap() async {
    final categories = await widget.database.categoryDao.findAllCategoriesOnce();
    if (!mounted) return;
    setState(() {
      _categoryMap = {for (final c in categories) if (c.id != null) c.id!: c};
    });
    widget.database.categoryDao.watchAllCategories().listen((categories) {
      if (!mounted) return;
      setState(() {
        _categoryMap = {for (final c in categories) if (c.id != null) c.id!: c};
      });
    });
  }

  List<Note> _filter(List<Note> notes) {
    if (_query.isEmpty) return notes;
    return notes.where((n) =>
    n.title.toLowerCase().contains(_query) ||
        n.content.toLowerCase().contains(_query)).toList();
  }

  Future<void> _deleteNote(Note note) async {
    await widget.database.noteDao.deleteNote(note);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Note deleted')));
  }

  Future<void> _openNote({Note? note}) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => AddEditNoteScreen(database: widget.database, note: note),
    ));
    // No manual reload — watchAllNotes() emits automatically on DB change.
  }

  Future<void> _openCategoryManager() async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => AddEditCategoryScreen(database: widget.database),
    ));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(icon: const Icon(Icons.category_outlined), onPressed: _openCategoryManager),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search notes...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Note>>(
              stream: widget.database.noteDao.watchAllNotes(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final notes = _filter(snapshot.data!);
                if (notes.isEmpty) return const Center(child: Text('No notes yet'));
                return ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    final category = note.categoryId != null ? _categoryMap[note.categoryId] : null;
                    return Dismissible(
                      key: ValueKey(note.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.redAccent,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (_) => _deleteNote(note),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(category != null && category.name.isNotEmpty
                              ? category.name[0].toUpperCase() : '\u00b7'),
                        ),
                        title: Text(note.title),
                        subtitle: Text(note.content, maxLines: 1, overflow: TextOverflow.ellipsis),
                        onTap: () => _openNote(note: note),
                      ),
                    );
                  },
                );
              },
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