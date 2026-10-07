import 'package:flutter/material.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

class BmiCalculatorScreen extends StatefulWidget {
  const BmiCalculatorScreen({super.key});
  @override
  State<BmiCalculatorScreen> createState() => _BmiCalculatorScreenState();
}

class _BmiCalculatorScreenState extends State<BmiCalculatorScreen> {
  final _height = TextEditingController();
  final _weight = TextEditingController();
  String _result = '';

  @override
  void dispose() {
    _height.dispose();
    _weight.dispose();
    super.dispose();
  }

  void _calculate() {
    final h = double.tryParse(_height.text);
    final w = double.tryParse(_weight.text);
    if (h == null || w == null) {
      setState(() => _result = 'Enter valid height and weight');
      return;
    }
    if (!(h >= 50 && h <= 300 && w >= 10 && w <= 500)) {
      setState(() => _result =
      'Height must be 50-300 cm and weight 10-500 kg');
      return;
    }
    final m = h / 100;
    final bmi = w / (m * m);
    final category = bmi < 18.5
        ? 'Underweight'
        : bmi < 25
        ? 'Normal'
        : bmi < 30
        ? 'Overweight'
        : 'Obese';
    setState(() => _result = 'BMI: ${bmi.toStringAsFixed(1)} ($category)');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        AppTextField(
          controller: _height,
          label: 'Height (cm)',
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        AppTextField(
          controller: _weight,
          label: 'Weight (kg)',
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 24),
        AppButton(text: 'Calculate', onPressed: _calculate),
        const SizedBox(height: 24),
        Text(_result, style: Theme.of(context).textTheme.headlineSmall),
      ]),
    );
  }
}