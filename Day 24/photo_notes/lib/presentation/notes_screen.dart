import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../widgets/loading_view.dart';
import '../data/notes_database.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final NotesDatabase _db = NotesDatabase();
  final TextEditingController _textController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> _notes = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  void dispose() {
    _textController.dispose(); // Proper disposal
    super.dispose();
  }

  String? _validate(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Please write something';
    if (text.length > AppConstants.maxNoteLength) {
      return 'Maximum ${AppConstants.maxNoteLength} characters';
    }
    return null;
  }

  Future<void> _refresh() async {
    try {
      final notes = await _db.getNotes();
      if (!mounted) return;
      setState(() => _notes = notes);
    } catch (e) {
      _showMessage('Could not load notes.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    try {
      await _db.addNote(_textController.text.trim());
      _textController.clear();
      await _refresh();
    } catch (e) {
      _showMessage('Could not save the note.');
    }
  }

  void _showMessage(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const LoadingView();
    return Padding(
      padding: const EdgeInsets.all(AppConstants.padding),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _textController,
              validator: _validate,
              decoration: InputDecoration(
                labelText: 'New note', // Accessibility label
                suffixIcon: IconButton(
                  icon: const Icon(Icons.save),
                  tooltip: 'Save note', // Accessibility label
                  onPressed: _save,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, i) => ListTile(title: Text(_notes[i])),
            ),
          ),
        ],
      ),
    );
  }
}