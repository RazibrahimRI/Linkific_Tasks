import 'package:flutter/material.dart';

class LoadingAnimationScreen extends StatefulWidget {
  const LoadingAnimationScreen({super.key});

  @override
  State<LoadingAnimationScreen> createState() => _LoadingAnimationScreenState();
}

class _LoadingAnimationScreenState extends State<LoadingAnimationScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loading Animation')),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final scale = 0.8 + 0.2 * (1 - (2 * _controller.value - 1).abs());
            return Transform.rotate(
              angle: _controller.value * 6.28318, // 2*pi
              child: Transform.scale(
                scale: scale,
                child: child,
              ),
            );
          },
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: [Colors.indigo.shade100, Colors.indigo],
              ),
            ),
          ),
        ),
      ),
    );
  }
}