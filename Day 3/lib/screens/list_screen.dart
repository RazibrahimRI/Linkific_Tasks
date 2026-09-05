import 'package:flutter/material.dart';
import '../widgets/item_card.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'title': 'Flutter Basics', 'icon': Icons.widgets},
      {'title': 'Git Version Control', 'icon': Icons.merge},
      {'title': 'State Management', 'icon': Icons.autorenew},
      {'title': 'REST APIs', 'icon': Icons.cloud},
      {'title': 'Firebase', 'icon': Icons.local_fire_department},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Topics')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ItemCard(
            title: item['title'] as String,
            subtitle: 'Tap to know more.',
            icon: item['icon'] as IconData,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tapped: ${item['title']}')),
              );
            },
          );
        },
      ),
    );
  }
}