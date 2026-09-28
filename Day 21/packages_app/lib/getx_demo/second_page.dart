import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'counter_controller.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dependency injection: get the SAME controller, no passing through constructors
    final controller = Get.find<CounterController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Second Page')),
      body: Center(
        child: Obx(() => Text('Same count here: ${controller.count}',
            style: const TextStyle(fontSize: 24))),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.back(), // GetX navigation: go back
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}