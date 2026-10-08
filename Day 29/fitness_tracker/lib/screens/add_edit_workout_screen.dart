import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/workout.dart';
import '../providers/workout_provider.dart';
import '../widgets/app_button.dart';

// One screen for both adding and editing. A null workout means add.
class AddEditWorkoutScreen extends StatefulWidget {
  final Workout? workout; // null = add, not null = edit
  const AddEditWorkoutScreen({super.key, this.workout});
  @override
  State<AddEditWorkoutScreen> createState() => _AddEditWorkoutScreenState();
}

// One screen for both adding and editing. A null workout means add.
class _AddEditWorkoutScreenState extends State<AddEditWorkoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _minutes = TextEditingController();
  late DateTime _date;
  bool _saving = false;

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
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final provider = context.read<WorkoutProvider>();
      final w = Workout(
        id: widget.workout?.id,
        name: _name.text.trim(),
        durationMinutes: int.parse(_minutes.text),
        date: _date,
      );
      if (widget.workout == null) {
        await provider.add(w);
      } else {
        await provider.update(w);
      }
      if (mounted) Navigator.pop(context);
    } catch (_) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not save. Try again.')),
        );
      }
    }
  }

  Future<void> _delete() async {
    setState(() => _saving = true);
    try {
      await context.read<WorkoutProvider>().delete(widget.workout!.id!);
      if (mounted) Navigator.pop(context);
    } catch (_) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not delete. Try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.workout != null;
    return Scaffold(
      appBar: AppBar(title: Text(editing ? 'Edit Workout' : 'Add Workout')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Enter a workout name'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _minutes,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Minutes'),
                validator: (v) {
                  final n = int.tryParse(v ?? '');
                  if (n == null || n <= 0) {
                    return 'Enter minutes greater than 0';
                  }
                  if (n > 1440) {
                    return 'Maximum is 1440 minutes';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              ListTile(
                title: Text('Date: ${_date.day}/${_date.month}/${_date.year}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              const SizedBox(height: 12),
              AppButton(text: 'Save', loading: _saving, onPressed: _save),
              if (editing)
                TextButton(
                  onPressed: _saving ? null : _delete,
                  child: const Text('Delete'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
