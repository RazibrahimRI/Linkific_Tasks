import 'package:flutter/material.dart';
import '/app_database.dart';
import '/note.dart';
import '/category.dart';

class AddEditNoteScreen extends StatefulWidget {
  final AppDatabase database;
  final Note? note;
  const AddEditNoteScreen({super.key, required this.database, this.note});

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  int? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(text: widget.note?.content ?? '');
    _selectedCategoryId = widget.note?.categoryId;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Title cannot be empty')));
      return;
    }
    if (widget.note == null) {
      await widget.database.noteDao.insertNote(Note(
        title: title,
        content: content,
        categoryId: _selectedCategoryId,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ));
    } else {
      await widget.database.noteDao.updateNote(widget.note!.copyWith(
        title: title,
        content: content,
        categoryId: _selectedCategoryId,
      ));
    }
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<void> _delete() async {
    if (widget.note == null) return;
    await widget.database.noteDao.deleteNote(widget.note!);
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.note != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit note' : 'New note'),
        actions: [
          if (isEditing) IconButton(icon: const Icon(Icons.delete_outline), onPressed: _delete),
          IconButton(icon: const Icon(Icons.check), onPressed: _save),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Title')),
            const SizedBox(height: 12),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: 'Content', alignLabelWithHint: true),
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
            const SizedBox(height: 12),
            StreamBuilder<List<Category>>(
              stream: widget.database.categoryDao.watchAllCategories(),
              builder: (context, snapshot) {
                final categories = snapshot.data ?? [];
                return DropdownButtonFormField<int?>(
                  value: _selectedCategoryId,
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: [
                    const DropdownMenuItem<int?>(value: null, child: Text('None')),
                    ...categories.map((c) => DropdownMenuItem<int?>(value: c.id, child: Text(c.name))),
                  ],
                  onChanged: (value) => setState(() => _selectedCategoryId = value),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}