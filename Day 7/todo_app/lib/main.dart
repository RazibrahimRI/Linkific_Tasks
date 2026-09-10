import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(home: TodoScreen());
}

class Todo {
  String title;
  bool done;
  bool isEditing;
  Todo(this.title, {this.done = false, this.isEditing = false});
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});
  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<Todo> _todos = [];
  final TextEditingController _addController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  String _query = '';
  String _filter = 'all'; // 'all', 'active', 'completed'

  @override
  void dispose() {
    _addController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _addTodo() {
    final text = _addController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _todos.add(Todo(text));
      _addController.clear();
    });
  }

  void _deleteTodo(Todo todo) {
    setState(() => _todos.remove(todo));
  }

  void _toggleTodo(Todo todo) {
    setState(() => todo.done = !todo.done);
  }

  void _startEditing(Todo todo) {
    setState(() => todo.isEditing = true);
  }

  void _saveEdit(Todo todo, String newTitle) {
    setState(() {
      if (newTitle.trim().isNotEmpty) {
        todo.title = newTitle.trim();
      }
      todo.isEditing = false;
    });
  }

  List<Todo> get _visibleTodos {
    List<Todo> result = [];
    for (var t in _todos) {
      bool matchesQuery = _query.isEmpty ||
          t.title.toLowerCase().contains(_query.toLowerCase());

      bool matchesFilter = true;
      if (_filter == 'active') {
        matchesFilter = !t.done;
      } else if (_filter == 'completed') {
        matchesFilter = t.done;
      }

      if (matchesQuery && matchesFilter) {
        result.add(t);
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final visible = _visibleTodos;
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search todos',
                border: OutlineInputBorder(),
              ),
              onChanged: (val) => setState(() => _query = val),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _filterChip('All', 'all'),
                const SizedBox(width: 8),
                _filterChip('Active', 'active'),
                const SizedBox(width: 8),
                _filterChip('Completed', 'completed'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _addController,
                    decoration: const InputDecoration(
                      hintText: 'Add a todo',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addTodo(),
                  ),
                ),
                IconButton(icon: const Icon(Icons.add), onPressed: _addTodo),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: visible.isEmpty
                  ? const Center(child: Text('No todos'))
                  : ListView.builder(
                itemCount: visible.length,
                itemBuilder: (ctx, i) {
                  final todo = visible[i];

                  if (todo.isEditing) {
                    final editController =
                    TextEditingController(text: todo.title);
                    return ListTile(
                      title: TextField(
                        controller: editController,
                        autofocus: true,
                        onSubmitted: (val) => _saveEdit(todo, val),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () =>
                            _saveEdit(todo, editController.text),
                      ),
                    );
                  }

                  return ListTile(
                    leading: Checkbox(
                      value: todo.done,
                      onChanged: (_) => _toggleTodo(todo),
                    ),
                    title: Text(
                      todo.title,
                      style: TextStyle(
                        decoration: todo.done
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _startEditing(todo),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteTodo(todo),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterChip(String label, String value) {
    return ChoiceChip(
      label: Text(label),
      selected: _filter == value,
      onSelected: (_) => setState(() => _filter = value),
    );
  }
}