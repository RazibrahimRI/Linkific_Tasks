import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class CrashScreen extends StatelessWidget {
  const CrashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crash Test')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                throw Exception('Test exception from button');
              },
              child: const Text('Throw exception (FlutterError.onError)'),
            ),
            ElevatedButton(
              onPressed: () => FirebaseCrashlytics.instance.crash(),
              child: const Text('Force crash'),
            ),
          ],
        ),
      ),
    );
  }
}