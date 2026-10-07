import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/goal.dart';
import '../providers/goal_provider.dart';
import '../providers/workout_provider.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/progress_block.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});
  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  final _weekly = TextEditingController();
  final _water = TextEditingController();
  bool _filled = false;
  bool _saving = false;

  @override
  void dispose() {
    _weekly.dispose();
    _water.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final w = int.tryParse(_weekly.text);
    final d = int.tryParse(_water.text);
    if (w == null || d == null || w <= 0 || d <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Enter numbers greater than 0')));
      return;
    }
    if (w > 10080 || d > 10000) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Weekly minutes max 10080, daily water max 10000 ml')));
      return;
    }
    setState(() => _saving = true);
    try {
      await context
          .read<GoalProvider>()
          .save(Goal(weeklyWorkoutMinutes: w, dailyWaterMl: d));
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Goals saved')));
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not save goals. Try again.')));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GoalProvider>();
    final done = context.watch<WorkoutProvider>().last7DaysTotal;

    if (provider.error != null) {
      return Center(child: Text(provider.error!));
    }
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (!_filled) {
      _weekly.text = provider.goal.weeklyWorkoutMinutes.toString();
      _water.text = provider.goal.dailyWaterMl.toString();
      _filled = true;
    }

    final goal = provider.goal;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ProgressBlock(
          label: 'Last 7 days (min)',
          current: done,
          target: goal.weeklyWorkoutMinutes,
        ),
        const SizedBox(height: 24),
        AppTextField(
          controller: _weekly,
          label: 'Weekly workout minutes',
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        AppTextField(
          controller: _water,
          label: 'Daily water (ml)',
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 24),
        AppButton(text: 'Save', loading: _saving, onPressed: _save),
      ]),
    );
  }
}