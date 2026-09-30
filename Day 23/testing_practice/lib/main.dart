import 'dart:ui';
import 'package:flutter/material.dart';
import 'basics_screen.dart';
import 'fast_screen.dart';

void main()  {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _open(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debug Practice')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Basics (Task 2)'),
            onTap: () => _open(context, const BasicsScreen()),
          ),
          ListTile(
            title: const Text('Fast Screen (Task 5, after)'),
            onTap: () => _open(context, const FastScreen()),
          ),
        ],
      ),
    );
  }
}