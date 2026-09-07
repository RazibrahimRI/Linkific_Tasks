import 'package:flutter/material.dart';

class StackDemo extends StatelessWidget {
  const StackDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stack Demo')),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(width: 200, height: 200, color: Colors.blue[100]),
            const Positioned(top: 10, right: 10, child: Icon(Icons.star, color: Colors.amber, size: 30)),
            const CircleAvatar(radius: 40, backgroundImage: NetworkImage('https://picsum.photos/100')),
            const Positioned(bottom: 10, right: 10, child: CircleAvatar(radius: 8, backgroundColor: Colors.green)),
          ],
        ),
      ),
    );
  }
}