import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'counter_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dependency injection: create the controller once and store it
    final controller = Get.put(CounterController());

    return Scaffold(
      appBar: AppBar(title: const Text('GetX Home')),
      body: Center(
        // Obx rebuilds only this Text when count changes
        child: Obx(() => Text('Count: ${controller.count}',
            style: const TextStyle(fontSize: 28))),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: TextButton(
        onPressed: () => Get.toNamed('/second'), // GetX navigation
        child: const Text('Go to second page'),
      ),
    );
  }
}