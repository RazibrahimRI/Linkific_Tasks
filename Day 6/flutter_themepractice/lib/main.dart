import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_theme.dart';
import 'home_screen.dart';


void main() {
  runApp(const MyApp());
}
class MainNav extends StatefulWidget {
  final ThemeMode currentMode;
  final ValueChanged<ThemeMode> onModeChanged;
  const MainNav({super.key, required this.currentMode, required this.onModeChanged});

  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(onModeChanged: widget.onModeChanged),
    ];

    return Scaffold(
      body: screens[_index],
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const _key = 'theme_mode';
  ThemeMode _mode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    _loadMode();
  }

  Future<void> _loadMode() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_key);
    setState(() {
      _mode = ThemeMode.values.firstWhere(
            (m) => m.name == saved,
        orElse: () => ThemeMode.system,
      );
    });
  }

  Future<void> setMode(ThemeMode mode) async {
    setState(() => _mode = mode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, mode.name);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _mode,
      home: MainNav(currentMode: _mode, onModeChanged: setMode),
    );
  }
}