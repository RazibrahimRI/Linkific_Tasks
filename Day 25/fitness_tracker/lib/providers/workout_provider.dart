import 'dart:async';
import 'package:flutter/material.dart';
import '../models/workout.dart';
import '../services/firestore_service.dart';

class WorkoutProvider extends ChangeNotifier {
  FirestoreService? _db;
  String? _uid;
  StreamSubscription? _sub;
  List<Workout> workouts = [];

  void setUser(String? uid) {
    if (uid == _uid) return;
    _uid = uid;
    _sub?.cancel();
    workouts = [];
    if (uid == null) {
      _db = null;
      return;
    }
    _db = FirestoreService(uid);
    _sub = _db!.workoutsStream().listen((list) {
      workouts = list;
      notifyListeners();
    });
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