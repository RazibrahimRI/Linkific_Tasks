import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../screens/bmi_calculator_screen.dart';
import '../screens/goals_screen.dart';
import '../screens/progress_charts_screen.dart';
import '../screens/water_tracker_screen.dart';
import '../screens/workout_list_screen.dart';

class MainBottomNav extends StatefulWidget {
  const MainBottomNav({super.key});
  @override
  State<MainBottomNav> createState() => _MainBottomNavState();
}

class _MainBottomNavState extends State<MainBottomNav> {
  int _index = 0;
  final _titles = ['Workouts', 'Progress', 'Goals', 'Water', 'BMI'];
  final _pages = const [
    WorkoutListScreen(),
    ProgressChartsScreen(),
    GoalsScreen(),
    WaterTrackerScreen(),
    BmiCalculatorScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_index]),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.read<AuthProvider>().logout(),
          ),
        ],
      ),
      body: _pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.fitness_center), label: 'Workouts'),
          NavigationDestination(icon: Icon(Icons.bar_chart), label: 'Charts'),
          NavigationDestination(icon: Icon(Icons.flag), label: 'Goals'),
          NavigationDestination(icon: Icon(Icons.water_drop), label: 'Water'),
          NavigationDestination(icon: Icon(Icons.monitor_weight), label: 'BMI'),
        ],
      ),
    );
  }
}