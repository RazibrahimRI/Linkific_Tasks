import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_practice/models/counter_model.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Method 1: Provider.of<T>(context) — rebuilds this widget on change
    final counterA = Provider.of<CounterModel>(context);

    // Method 2: context.watch<T>() — same as Provider.of, shorthand syntax
    final counterB = context.watch<CounterModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Provider Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Count (watch): ${counterB.count}'),

            // Method 3: Consumer widget — only rebuilds this part of the tree
            Consumer<CounterModel>(
              builder: (context, counter, child) {
                return Text('Count (Consumer): ${counter.count}');
              },
            ),

            ElevatedButton(
              // Method 4: context.read<T>() — does NOT rebuild, use inside
              // callbacks/onPressed where you only need to call a method
              onPressed: () => context.read<CounterModel>().increment(),
              child: const Text('Increment'),
            ),
            ElevatedButton(
              onPressed: () => context.read<CounterModel>().decrement(),
              child: const Text('Decrement'),
            ),
          ],
        ),
      ),
    );
  }
}