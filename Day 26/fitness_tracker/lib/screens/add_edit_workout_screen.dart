import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/workout.dart';
import '../providers/workout_provider.dart';

class AddEditWorkoutScreen extends StatefulWidget {
  final Workout? workout; // null = add, not null = edit
  const AddEditWorkoutScreen({super.key, this.workout});
  @override
  State<AddEditWorkoutScreen> createState() => _AddEditWorkoutScreenState();
}

class _AddEditWorkoutScreenState extends State<AddEditWorkoutScreen> {
  final _name = TextEditingController();
  final _minutes = TextEditingController();
  late DateTime _date;

  @override
  void initState() {
    super.initState();
    final w = widget.workout;
    _name.text = w?.name ?? '';
    _minutes.text = w?.durationMinutes.toString() ?? '';
    _date = w?.date ?? DateTime.now();
  }

  @override
  void dispose() {
    _name.dispose();
    _minutes.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (d != null) setState(() => _date = d);
  }

  Future<void> _save() async {
    final minutes = int.tryParse(_minutes.text);
    if (_name.text.trim().isEmpty || minutes == null || minutes <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Enter a name and valid minutes')));
      return;
    }
    final provider = context.read<WorkoutProvider>();
    final w = Workout(
      id: widget.workout?.id,
      name: _name.text.trim(),
      durationMinutes: minutes,
      date: _date,
    );
    if (widget.workout == null) {
      await provider.add(w);
    } else {
      await provider.update(w);
    }
    if (mounted) Navigator.pop(context);
  }

  Future<void> _delete() async {
    await context.read<WorkoutProvider>().delete(widget.workout!.id!);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.workout != null;
    return Scaffold(
      appBar: AppBar(title: Text(editing ? 'Edit Workout' : 'Add Workout')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'Name')),
          const SizedBox(height: 12),
          TextField(
              controller: _minutes,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Minutes')),
          const SizedBox(height: 12),
          ListTile(
            title: Text('Date: ${_date.day}/${_date.month}/${_date.year}'),
            trailing: const Icon(Icons.calendar_today),
            onTap: _pickDate,
          ),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: _save, child: const Text('Save')),
          if (editing)
            TextButton(onPressed: _delete, child: const Text('Delete')),
        ]),
      ),
    );
  }
}