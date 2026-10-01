import 'package:flutter/material.dart';
import '/constants/app_constants.dart';
import '/storage/secure_store.dart';
import '/theme/app_theme.dart';
import 'home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    // Demo value only. Shows where a real secret would be stored.
    await SecureStore().save(AppConstants.tokenKey, 'demo-token');
  } catch (e) {
    debugPrint('Secure storage failed');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}