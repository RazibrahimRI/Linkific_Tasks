import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/goal_provider.dart';
import '../providers/water_provider.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/progress_block.dart';

class WaterTrackerScreen extends StatefulWidget {
  const WaterTrackerScreen({super.key});
  @override
  State<WaterTrackerScreen> createState() => _WaterTrackerScreenState();
}

class _WaterTrackerScreenState extends State<WaterTrackerScreen> {
  final _ml = TextEditingController();

  @override
  void dispose() {
    _ml.dispose();
    super.dispose();
  }

  Future<void> _add() async {
    final ml = int.tryParse(_ml.text);
    if (ml == null || ml <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Enter a valid amount in ml')));
      return;
    }
    await context.read<WaterProvider>().add(ml);
    _ml.clear();
  }

  @override
  Widget build(BuildContext context) {
    final water = context.watch<WaterProvider>();
    final goal = context.watch<GoalProvider>().goal;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        ProgressBlock(
          label: 'Today (ml)',
          current: water.totalMl,
          target: goal.dailyWaterMl,
        ),
        const SizedBox(height: 16),
        AppTextField(
          controller: _ml,
          label: 'Amount (ml)',
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        AppButton(text: 'Add', onPressed: _add),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: water.logs.length,
            itemBuilder: (context, i) {
              final l = water.logs[i];
              final time =
                  '${l.date.hour}:${l.date.minute.toString().padLeft(2, '0')}';
              return ListTile(
                title: Text('${l.amountMl} ml'),
                trailing: Text(time),
              );
            },
          ),
        ),
      ]),
    );
  }
}