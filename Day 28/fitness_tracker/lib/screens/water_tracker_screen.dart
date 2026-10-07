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
  bool _saving = false;

  @override
  void dispose() {
    _ml.dispose();
    super.dispose();
  }

  Future<void> _add() async {
    final ml = int.tryParse(_ml.text);
    if (ml == null || ml <= 0 || ml > 5000) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Enter an amount between 1 and 5000 ml')));
      return;
    }
    setState(() => _saving = true);
    try {
      await context.read<WaterProvider>().add(ml);
      _ml.clear();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not save. Try again.')));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _delete(String id) async {
    try {
      await context.read<WaterProvider>().delete(id);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not delete. Try again.')));
      }
    }
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
        AppButton(text: 'Add', loading: _saving, onPressed: _add),
        const SizedBox(height: 16),
        Expanded(
          child: water.error != null
              ? Center(child: Text(water.error!))
              : water.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: water.logs.length,
            itemBuilder: (context, i) {
              final l = water.logs[i];
              final time =
                  '${l.date.hour}:${l.date.minute.toString().padLeft(2, '0')}';
              return ListTile(
                title: Text('${l.amountMl} ml'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(time),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed:
                      l.id == null ? null : () => _delete(l.id!),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}