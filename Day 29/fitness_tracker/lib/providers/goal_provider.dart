import 'dart:async';

import 'package:flutter/material.dart';

import '../models/goal.dart';
import '../services/firestore_service.dart';

// Holds the saved goal. The Goals screen waits for isLoading to finish before filling its fields.
class GoalProvider extends ChangeNotifier {
  FirestoreService? _db;
  String? _uid;
  StreamSubscription? _sub;
  Goal goal = const Goal();
  bool isLoading = false;
  String? error;

  void setUser(String? uid) {
    if (uid == _uid) return;
    _uid = uid;
    _sub?.cancel();
    goal = const Goal();
    error = null;
    if (uid == null) {
      _db = null;
      isLoading = false;
      return;
    }
    isLoading = true;
    _db = FirestoreService(uid);
    _sub = _db!.goalStream().listen(
      (g) {
        goal = g;
        error = null;
        isLoading = false;
        notifyListeners();
      },
      onError: (_) {
        error = 'Could not load goals.';
        isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> save(Goal g) => _db!.saveGoal(g);

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
