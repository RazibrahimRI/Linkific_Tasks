import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_tracker/providers/water_provider.dart';
import 'package:fitness_tracker/providers/workout_provider.dart';
import 'package:fitness_tracker/screens/splash_screen.dart';
import 'package:fitness_tracker/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'screens/login_screen.dart';
import 'widgets/main_bottom_nav.dart';
import 'providers/goal_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, WorkoutProvider>(
          create: (_) => WorkoutProvider(),
          update: (_, auth, p) => p!..setUser(auth.user?.uid),
        ),
        ChangeNotifierProxyProvider<AuthProvider, GoalProvider>(
          create: (_) => GoalProvider(),
          update: (_, auth, p) => p!..setUser(auth.user?.uid),
        ),
        ChangeNotifierProxyProvider<AuthProvider, WaterProvider>(
          create: (_) => WaterProvider(),
          update: (_, auth, p) => p!..setUser(auth.user?.uid),
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
      title: 'Fitness Tracker',
      theme: AppTheme.light,
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    if (!auth.initialized) return const SplashScreen();
    return auth.user == null ? const LoginScreen() : const MainBottomNav();
  }
}