import 'package:flutter/foundation.dart';

class CounterModel extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners(); // tells all listening widgets to rebuild
  }

  void decrement() {
    _count--;
    notifyListeners();
  }
}