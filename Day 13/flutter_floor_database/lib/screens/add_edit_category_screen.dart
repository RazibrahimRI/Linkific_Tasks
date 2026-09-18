import 'package:flutter/material.dart';
import '/app_database.dart';
import '/category.dart';

class AddEditCategoryScreen extends StatefulWidget {
  final AppDatabase database;
  const AddEditCategoryScreen({super.key, required this.database});

  @override
  State<AddEditCategoryScreen> createState() => _AddEditCategoryScreenState();
}

class _AddEditCategoryScreenState extends State<AddEditCategoryScreen> {
  final TextEditingController _nameController = TextEditingController();

  Future<void> _addCategory() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    await widget.database.categoryDao.insertCategory(Category(name: name));
    _nameController.clear();
  }

  Future<void> _renameCategory(Category category) async {
    final controller = TextEditingController(text: category.name);
    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rename category'),
        content: TextField(controller: controller, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.of(context).pop(controller.text.trim()), child: const Text('Save')),
        ],
      ),
    );
    if (newName != null && newName.isNotEmpty && newName != category.name) {
      await widget.database.categoryDao.updateCategory(category.copyWith(name: newName));
    }
  }

  Future<void> _deleteCategory(Category category) async {
    // FK onDelete: setNull clears note.category_id instead of deleting notes.
    await widget.database.categoryDao.deleteCategory(category);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'New category name'),
                  onSubmitted: (_) => _addCategory(),
                )),
                IconButton(icon: const Icon(Icons.add), onPressed: _addCategory),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Category>>(
              stream: widget.database.categoryDao.watchAllCategories(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final categories = snapshot.data!;
                if (categories.isEmpty) return const Center(child: Text('No categories yet'));
                return ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return ListTile(
                      title: Text(category.name),
                      onTap: () => _renameCategory(category),
                      trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => _deleteCategory(category)),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}