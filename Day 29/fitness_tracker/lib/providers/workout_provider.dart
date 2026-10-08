import 'dart:async';

import 'package:flutter/material.dart';

import '../models/workout.dart';
import '../services/firestore_service.dart';

// Holds the user's workouts, listens to Firestore live, and tracks loading and error state.
class WorkoutProvider extends ChangeNotifier {
  FirestoreService? _db;
  String? _uid;
  StreamSubscription? _sub;
  List<Workout> workouts = [];
  bool isLoading = false;
  String? error;

  // Minutes of workouts for each of the last 7 days, oldest first. Used by the chart.
  List<int> minutesLast7Days() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return List.generate(7, (i) {
      final day = today.subtract(Duration(days: 6 - i));
      return workouts
          .where(
            (w) =>
                w.date.year == day.year &&
                w.date.month == day.month &&
                w.date.day == day.day,
          )
          .fold<int>(0, (sum, w) => sum + w.durationMinutes);
    });
  }

  int get last7DaysTotal => minutesLast7Days().fold<int>(0, (a, b) => a + b);

  // Called when the user logs in or out. Starts or stops the live Firestore listener.
  void setUser(String? uid) {
    if (uid == _uid) return;
    _uid = uid;
    _sub?.cancel();
    workouts = [];
    error = null;
    if (uid == null) {
      _db = null;
      isLoading = false;
      return;
    }
    isLoading = true;
    _db = FirestoreService(uid);
    _sub = _db!.workoutsStream().listen(
      (list) {
        workouts = list;
        error = null;
        isLoading = false;
        notifyListeners();
      },
      onError: (_) {
        error = 'Could not load workouts.';
        isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> add(Workout w) => _db!.addWorkout(w);
  Future<void> update(Workout w) => _db!.updateWorkout(w);
  Future<void> delete(String id) => _db!.deleteWorkout(id);

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
