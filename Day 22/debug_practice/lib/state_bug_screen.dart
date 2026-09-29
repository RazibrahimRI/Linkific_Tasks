import 'package:flutter/material.dart';

class StateBugScreen extends StatefulWidget {
  const StateBugScreen({super.key});

  @override
  State<StateBugScreen> createState() => _StateBugScreenState();
}

class _StateBugScreenState extends State<StateBugScreen> {
  int _count = 0;

  void _increment() {
    _count++; // BUG: no setState, so the screen does not rebuild
    debugPrint('count is now $_count');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('State Bug')),
      body: Center(child: Text('Count: $_count', style: const TextStyle(fontSize: 32))),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}