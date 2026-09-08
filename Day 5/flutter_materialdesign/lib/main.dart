import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/form_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material Showcase',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      initialRoute: '/login',
      // onGenerateRoute lets named routes carry data (settings.arguments),
      // so /dashboard can still be a named route even though it needs
      // the email string from Login. This is the cleaner way to do
      // "named routes + passing data" together, instead of mixing
      // named routes for some screens and MaterialPageRoute for others.
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          case '/register':
            return MaterialPageRoute(builder: (_) => const RegisterScreen());
          case '/dashboard':
            final email = settings.arguments as String? ?? 'unknown user';
            return MaterialPageRoute(builder: (_) => DashboardScreen(userEmail: email));
          case '/form':
            return MaterialPageRoute(builder: (_) => const FormScreen());
          default:
            return MaterialPageRoute(builder: (_) => const LoginScreen());
        }
      },
    );
  }
}