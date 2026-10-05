import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/workout_provider.dart';
import 'add_edit_workout_screen.dart';

class WorkoutListScreen extends StatelessWidget {
  const WorkoutListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final workouts = context.watch<WorkoutProvider>().workouts;
    return Scaffold(
      body: workouts.isEmpty
          ? const Center(child: Text('No workouts yet. Tap + to add one.'))
          : ListView.builder(
        itemCount: workouts.length,
        itemBuilder: (context, i) {
          final w = workouts[i];
          return ListTile(
            title: Text(w.name),
            subtitle: Text('${w.durationMinutes} min'),
            trailing:
            Text('${w.date.day}/${w.date.month}/${w.date.year}'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => AddEditWorkoutScreen(workout: w)),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddEditWorkoutScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}