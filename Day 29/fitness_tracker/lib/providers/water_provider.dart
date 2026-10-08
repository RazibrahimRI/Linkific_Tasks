import 'dart:async';

import 'package:flutter/material.dart';

import '../models/water_log.dart';
import '../services/firestore_service.dart';

// Holds today's water entries and total, listens to Firestore live.
class WaterProvider extends ChangeNotifier {
  FirestoreService? _db;
  String? _uid;
  StreamSubscription? _sub;
  List<WaterLog> logs = [];
  bool isLoading = false;
  String? error;

  int get totalMl => logs.fold<int>(0, (sum, l) => sum + l.amountMl);

  // Called when the user logs in or out. Starts or stops the live Firestore listener.
  void setUser(String? uid) {
    if (uid == _uid) return;
    _uid = uid;
    _sub?.cancel();
    logs = [];
    error = null;
    if (uid == null) {
      _db = null;
      isLoading = false;
      return;
    }
    isLoading = true;
    _db = FirestoreService(uid);
    _sub = _db!.todayWaterStream().listen(
      (list) {
        logs = list;
        error = null;
        isLoading = false;
        notifyListeners();
      },
      onError: (_) {
        error = 'Could not load water entries.';
        isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> add(int ml) =>
      _db!.addWater(WaterLog(amountMl: ml, date: DateTime.now()));
  Future<void> delete(String id) => _db!.deleteWaterLog(id);

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
