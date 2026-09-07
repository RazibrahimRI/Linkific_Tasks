import 'package:flutter/material.dart';

class FlexDemo extends StatelessWidget {
  const FlexDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flex Demo')),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(8), child: Text('Expanded 1:2 ratio')),
            Row(
              children: [
                Expanded(flex: 1, child: Container(height: 60, color: Colors.blue)),
                Expanded(flex: 2, child: Container(height: 60, color: Colors.green)),
              ],
            ),
            const Padding(padding: EdgeInsets.all(8), child: Text('Flexible (shrinks to content, unlike Expanded)')),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    height: 60,
                    color: Colors.orange,
                    child: const FittedBox(child: Text('Flexible')),
                  ),
                ),
                Flexible(flex: 2, child: Container(height: 60, color: Colors.purple)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}