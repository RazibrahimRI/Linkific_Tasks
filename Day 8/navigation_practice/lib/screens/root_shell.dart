import 'package:flutter/material.dart';
import 'profile.dart';
import 'settings.dart';
import 'home.dart';
import 'details_screen.dart';

class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _currentIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys =
  List.generate(3, (_) => GlobalKey<NavigatorState>());

  final List<Widget> _tabs = const [HomeTab(), ProfileTab(), SettingsTab()];

  void _selectTab(int index) {
    Navigator.pop(context); // close drawer
    setState(() => _currentIndex = index);
  }

  void _openDetailsFromDrawer() {
    Navigator.pop(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const DetailsScreen(),
        settings: const RouteSettings(arguments: 'Guest'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Navigation Demo')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(title: const Text('Home'), onTap: () => _selectTab(0)),
            ListTile(title: const Text('Profile'), onTap: () => _selectTab(1)),
            ListTile(title: const Text('Settings'), onTap: () => _selectTab(2)),
            ListTile(title: const Text('Details'), onTap: _openDetailsFromDrawer),
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: List.generate(_tabs.length, (index) {
          return Navigator(
            key: _navigatorKeys[index],
            // This nested Navigator handles its tab's own route table.
            // Home tab pushes '/details' THROUGH this, not the root —
            // that's what keeps the bottom nav bar visible.
            onGenerateRoute: (settings) {
              if (settings.name == '/details') {
                return MaterialPageRoute(
                  builder: (_) => const DetailsScreen(),
                  settings: settings,
                );
              }
              return MaterialPageRoute(builder: (_) => _tabs[index]);
            },
          );
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}