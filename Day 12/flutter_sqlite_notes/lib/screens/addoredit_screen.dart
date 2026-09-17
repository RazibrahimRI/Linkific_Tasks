import 'package:flutter/material.dart';
import 'package:flutter_sqlite_notes/models_.dart';
import 'package:flutter_sqlite_notes/database_.dart';

class AddEditNoteScreen extends StatefulWidget {
  final Note? note;
  const AddEditNoteScreen({super.key, this.note});
  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  List<Category> _categories = [];
  int? _selectedCategoryId;
  bool _loadingCategories = true;
  bool get _isEditing => widget.note != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(text: widget.note?.content ?? '');
    _selectedCategoryId = widget.note?.categoryId;
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final categories = await DatabaseHelper.instance.getAllCategories();
    setState(() {
      _categories = categories;
      _loadingCategories = false;
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final now = DateTime.now().toIso8601String();

    if (_isEditing) {
      final updated = widget.note!.copyWith(
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        categoryId: _selectedCategoryId,
      );
      await DatabaseHelper.instance.updateNote(updated);
    } else {
      final newNote = Note(
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        categoryId: _selectedCategoryId,
        createdAt: now,
      );
      await DatabaseHelper.instance.insertNote(newNote);
    }
    if (mounted) Navigator.pop(context, true);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Note' : 'New Note'),
        actions: [IconButton(icon: const Icon(Icons.check), onPressed: _save)],
      ),
      body: _loadingCategories
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                    labelText: 'Title', border: OutlineInputBorder()),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Title is required'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true),
                minLines: 5,
                maxLines: 10,
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Content is required'
                    : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int?>(
                value: _selectedCategoryId,
                decoration: const InputDecoration(
                    labelText: 'Category', border: OutlineInputBorder()),
                items: [
                  const DropdownMenuItem<int?>(
                      value: null, child: Text('No category')),
                  ..._categories.map(
                        (c) => DropdownMenuItem<int?>(value: c.id, child: Text(c.name)),
                  ),
                ],
                onChanged: (value) => setState(() => _selectedCategoryId = value),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save),
                label: Text(_isEditing ? 'Update Note' : 'Save Note'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}