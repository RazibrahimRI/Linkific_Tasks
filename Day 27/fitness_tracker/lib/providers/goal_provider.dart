import 'dart:async';
import 'package:flutter/material.dart';
import '../models/goal.dart';
import '../services/firestore_service.dart';

class GoalProvider extends ChangeNotifier {
  FirestoreService? _db;
  String? _uid;
  StreamSubscription? _sub;
  Goal goal = const Goal();

  void setUser(String? uid) {
    if (uid == _uid) return;
    _uid = uid;
    _sub?.cancel();
    goal = const Goal();
    if (uid == null) {
      _db = null;
      return;
    }
    _db = FirestoreService(uid);
    _sub = _db!.goalStream().listen((g) {
      goal = g;
      notifyListeners();
    });
  }

  Future<void> save(Goal g) => _db!.saveGoal(g);

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}