import 'package:flutter/material.dart';

class SlowScreen extends StatefulWidget {
  const SlowScreen({super.key});

  @override
  State<SlowScreen> createState() => _SlowScreenState();
}

class _SlowScreenState extends State<SlowScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    debugPrint('SlowScreen build');

    // BAD: expensive work inside build, runs on every rebuild
    int total = 0;
    for (int i = 0; i < 30000000; i++) {
      total += i;
    }

    return Scaffold(
      appBar: AppBar(title: Text('Slow Screen')),
      body: Column(
        children: [
          Icon(Icons.speed), // BAD: not const
          Text('Static label'), // BAD: not const
          Text('Total: $total'),
          Text('Counter: $_counter'),
          CircularProgressIndicator(), // spinner makes the freeze easy to see
          Expanded(
            child: ListView.builder(
              itemCount: 200,
              itemBuilder: (context, i) => ListTile(title: Text('Item $i')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _counter++),
        child: Icon(Icons.add),
      ),
    );
  }
}