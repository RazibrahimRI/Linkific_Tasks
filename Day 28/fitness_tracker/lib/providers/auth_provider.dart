import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final _service = AuthService();
  User? user;
  bool loading = false;
  bool initialized = false;
  String? error;
  late final StreamSubscription<User?> _sub;

  AuthProvider() {
    user = _service.currentUser;
    _sub = _service.userChanges.listen((u) {
      user = u;
      initialized = true;
      notifyListeners();
    });
  }

  Future<bool> login(String email, String password) =>
      _run(() => _service.login(email, password));

  Future<bool> signUp(String email, String password) =>
      _run(() => _service.signUp(email, password));

  Future<void> logout() => _service.logout();

  Future<bool> _run(Future<void> Function() action) async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      await action();
      loading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      error = e.message;
      loading = false;
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}