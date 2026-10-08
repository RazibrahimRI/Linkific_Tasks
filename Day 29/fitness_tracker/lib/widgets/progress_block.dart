import 'package:flutter/material.dart';

class ProgressBlock extends StatelessWidget {
  final String label;
  final num current;
  final num target;

  const ProgressBlock({
    super.key,
    required this.label,
    required this.current,
    required this.target,
  });

  @override
  Widget build(BuildContext context) {
    final progress = target <= 0
        ? 0.0
        : (current / target).clamp(0.0, 1.0).toDouble();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: $current / $target'),
        const SizedBox(height: 8),
        LinearProgressIndicator(value: progress, minHeight: 10),
      ],
    );
  }
}
