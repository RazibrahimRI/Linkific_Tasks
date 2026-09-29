import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'basics_screen.dart';
import 'overflow_screen.dart';
import 'state_bug_screen.dart';
import 'leaky_screen.dart';
import 'network_screen.dart';
import 'slow_screen.dart';
import 'fast_screen.dart';
import 'crash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    FirebaseCrashlytics.instance.recordFlutterFatalError(details);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

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
            title: const Text('Layout Overflow (Task 4)'),
            onTap: () => _open(context, const OverflowScreen()),
          ),
          ListTile(
            title: const Text('State Not Updating (Task 4)'),
            onTap: () => _open(context, const StateBugScreen()),
          ),
          ListTile(
            title: const Text('Memory Leak (Task 4)'),
            onTap: () => _open(context, const LeakyScreen()),
          ),
          ListTile(
            title: const Text('Network Errors (Task 4)'),
            onTap: () => _open(context, const NetworkScreen()),
          ),
          ListTile(
            title: const Text('Slow Screen (Task 5, before)'),
            onTap: () => _open(context, const SlowScreen()),
          ),
          ListTile(
            title: const Text('Fast Screen (Task 5, after)'),
            onTap: () => _open(context, const FastScreen()),
          ),
          ListTile(
            title: const Text('Crash Test (Task 6)'),
            onTap: () => _open(context, const CrashScreen()),
          ),
        ],
      ),
    );
  }
}