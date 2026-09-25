import 'package:flutter/foundation.dart';

class Product {
  final String name;
  final double price;
  Product({required this.name, required this.price});
}

class CartModel extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => _items;

  double get totalPrice =>
      _items.fold(0, (sum, item) => sum + item.price);

  void addItem(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void removeItem(Product product) {
    _items.remove(product);
    notifyListeners();
  }
}