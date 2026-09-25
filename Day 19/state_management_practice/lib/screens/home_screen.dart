import 'package:flutter/material.dart';
import 'package:state_management_practice/screens/todo_screen.dart';
import 'auth_screen.dart';
import 'cart_screen.dart';
import 'counter_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Provider Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const CounterScreen())),
              child: const Text('Counter'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const TodoScreen())),
              child: const Text('Todo'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) =>  CartScreen())),
              child: const Text('Cart'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const AuthScreen())),
              child: const Text('Auth'),
            ),
          ],
        ),
      ),
    );
  }
}