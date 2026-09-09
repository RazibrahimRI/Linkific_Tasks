import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final ValueChanged<ThemeMode> onModeChanged;
  const HomeScreen({super.key, required this.onModeChanged});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.star, color: scheme.primary),
              title: Text('Item 1', style: text.titleMedium),
              subtitle: Text('Yo ssup', style: text.bodyMedium),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: Icon(Icons.favorite, color: scheme.primary),
              title: Text('Item 2', style: text.titleMedium),
              subtitle: Text('hellooooo', style: text.bodyMedium),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => onModeChanged(ThemeMode.light),
                child: const Text('Light'),
              ),
              OutlinedButton(
                onPressed: () => onModeChanged(ThemeMode.dark),
                child: const Text('Dark'),
              ),
              TextButton(
                onPressed: () => onModeChanged(ThemeMode.system),
                child: const Text('System'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}