import 'dart:async';
import 'package:flutter/material.dart';
import '../models/water_log.dart';
import '../services/firestore_service.dart';

class WaterProvider extends ChangeNotifier {
  FirestoreService? _db;
  String? _uid;
  StreamSubscription? _sub;
  List<WaterLog> logs = [];

  int get totalMl => logs.fold<int>(0, (sum, l) => sum + l.amountMl);

  void setUser(String? uid) {
    if (uid == _uid) return;
    _uid = uid;
    _sub?.cancel();
    logs = [];
    if (uid == null) {
      _db = null;
      return;
    }
    _db = FirestoreService(uid);
    _sub = _db!.todayWaterStream().listen((list) {
      logs = list;
      notifyListeners();
    });
  }

  Future<void> add(int ml) =>
      _db!.addWater(WaterLog(amountMl: ml, date: DateTime.now()));

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}