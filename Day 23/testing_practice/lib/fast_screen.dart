import 'package:flutter/material.dart';

class FastScreen extends StatefulWidget {
  const FastScreen({super.key});

  @override
  State<FastScreen> createState() => _FastScreenState();
}

class _FastScreenState extends State<FastScreen> {
  late final int _total;

  @override
  void initState() {
    super.initState();
    // FIXED: expensive work runs once, not on every build
    int total = 0;
    for (int i = 0; i < 30000000; i++) {
      total += i;
    }
    _total = total;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('FastScreen build');
    return Scaffold(
      appBar: AppBar(title: const Text('Fast Screen')),
      body: Column(
        children: [
          const Icon(Icons.speed),
          const Text('Static label'),
          Text('Total: $_total'),
          const CounterSection(), // counter has its own state
          const CircularProgressIndicator(),
          Expanded(
            child: ListView.builder(
              itemCount: 200,
              itemBuilder: (context, i) => ListTile(title: Text('Item $i')),
            ),
          ),
        ],
      ),
    );
  }
}

// Only this small widget rebuilds when the counter changes
class CounterSection extends StatefulWidget {
  const CounterSection({super.key});

  @override
  State<CounterSection> createState() => _CounterSectionState();
}

class _CounterSectionState extends State<CounterSection> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    debugPrint('CounterSection build');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Counter: $_counter'),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: () => setState(() => _counter++),
          child: const Text('Add'),
        ),
      ],
    );
  }
}