import 'package:flutter/material.dart';

class BasicsScreen extends StatefulWidget {
  const BasicsScreen({super.key});

  @override
  State<BasicsScreen> createState() => _BasicsScreenState();
}

class _BasicsScreenState extends State<BasicsScreen> {
  int _count = 0;

  void _increment() {
    print('print: button tapped');
    debugPrint('debugPrint: count before = $_count');
    setState(() {
      _count++; // put a breakpoint on this line
    });
    debugPrint('debugPrint: count after = $_count');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Basics')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Count: $_count', style: const TextStyle(fontSize: 32)),
            ElevatedButton(onPressed: _increment, child: const Text('Tap')),
          ],
        ),
      ),
    );
  }
}