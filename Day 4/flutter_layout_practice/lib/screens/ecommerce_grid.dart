import 'package:flutter/material.dart';

class EcommerceGrid extends StatelessWidget {
  const EcommerceGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.75,
        ),
        itemCount: 20,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Expanded(child: Image.network('https://picsum.photos/200?random=$index', fit: BoxFit.cover)),
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: Text('Product $index\n₹${(index + 1) * 199}'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}