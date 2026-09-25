import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_practice/models/cart_model.dart';


class CartScreen extends StatelessWidget {
   CartScreen({super.key});

  final List<Product> catalog = [
    Product(name: 'Book', price: 250),
    Product(name: 'Pen', price: 20),
    Product(name: 'Bag', price: 900),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping Cart (Provider)')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: catalog.length,
              itemBuilder: (context, index) {
                final product = catalog[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('₹${product.price}'),
                  trailing: ElevatedButton(
                    onPressed: () =>
                        context.read<CartModel>().addItem(product),
                    child: const Text('Add'),
                  ),
                );
              },
            ),
          ),
          const Divider(),
          Consumer<CartModel>(
            builder: (context, cart, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Cart: ${cart.items.length} items — Total: ₹${cart.totalPrice}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}