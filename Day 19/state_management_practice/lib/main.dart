import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_practice/screens/home_screen.dart';
import 'models/auth_model.dart';
import 'models/cart_model.dart';
import 'models/counter_model.dart';
import 'models/todo_model.dart';

class Greeting {
  final String text;
  Greeting(this.text);
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterModel()),
        ChangeNotifierProvider(create: (_) => TodoModel()),
        ChangeNotifierProvider(create: (_) => CartModel()),
        ChangeNotifierProvider(create: (_) => AuthModel()),

        ProxyProvider<AuthModel, Greeting>(
          update: (context, auth, previous) => Greeting(
            auth.isLoggedIn ? 'Hello, ${auth.username}' : 'Hello, Guest',
          ),
        ),

        FutureProvider<String>(
          create: (context) async {
            await Future.delayed(const Duration(seconds: 2)); // pretend loading
            return 'Loaded data';
          },
          initialData: 'Loading...', // shown while waiting
        ),

        StreamProvider<int>(
          create: (context) =>
              Stream.periodic(const Duration(seconds: 1), (count) => count),
          initialData: 0,
        ),
      ],
      child: const MyApp(),
    ),

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}