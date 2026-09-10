import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen()
  );
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});
  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  double? _firstOperand;
  String? _pendingOperator;
  bool _shouldResetDisplay = false;

  void _inputDigit(String digit) {
    setState(() {
      if (_display == '0' || _shouldResetDisplay) {
        _display = digit;
        _shouldResetDisplay = false;
      } else {
        _display += digit;
      }
    });
  }

  void _inputOperator(String op) {
    setState(() {
      if (_firstOperand != null && _pendingOperator != null && !_shouldResetDisplay) {
        _calculate();
      }
      _firstOperand = double.parse(_display);
      _pendingOperator = op;
      _shouldResetDisplay = true;
    });
  }

  void _calculate() {
    if (_firstOperand == null || _pendingOperator == null) return;
    final second = double.parse(_display);
    double result;
    switch (_pendingOperator) {
      case '+':
        result = _firstOperand! + second;
        break;
      case '-':
        result = _firstOperand! - second;
        break;
      case '×':
        result = _firstOperand! * second;
        break;
      case '÷':
        result = second == 0 ? double.nan : _firstOperand! / second;
        break;
      default:
        result = second;
    }
    setState(() {
      _display = _formatResult(result);
      _firstOperand = null;
      _pendingOperator = null;
      _shouldResetDisplay = true;
    });
  }

  String _formatResult(double value) {
    if (value.isNaN) return 'Error';
    if (value == value.roundToDouble()) return value.toInt().toString();
    return value.toString();
  }

  void _clear() {
    setState(() {
      _display = '0';
      _firstOperand = null;
      _pendingOperator = null;
      _shouldResetDisplay = false;
    });
  }

  void _backspace() {
    setState(() {
      if (_display.length <= 1) {
        _display = '0';
      } else {
        _display = _display.substring(0, _display.length - 1);
      }
    });
  }

  Widget _buildButton(String label, {Color? color, VoidCallback? onTap}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 20),
          ),
          onPressed: onTap ?? () => _inputDigit(label),
          child: Text(label, style: const TextStyle(fontSize: 22)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(_display, style: const TextStyle(fontSize: 48)),
            ),
          ),
          Row(children: [
            _buildButton('C',  onTap: _clear),
            _buildButton('⌫',  onTap: _backspace),
            _buildButton('÷', onTap: () => _inputOperator('÷')),
          ]),
          Row(children: [
            _buildButton('7'), _buildButton('8'), _buildButton('9'),
          ]),
          Row(children: [
            _buildButton('4'), _buildButton('5'), _buildButton('6'),
          ]),
          Row(children: [
            _buildButton('1'), _buildButton('2'), _buildButton('3'),
          ]),
          Row(children: [
            _buildButton('0'),
            _buildButton('=',  onTap: _calculate),
            _buildButton('×',  onTap: () => _inputOperator('×')),
          ]),
          Row(children: [
            _buildButton('−',  onTap: () => _inputOperator('-')),
            _buildButton('+',  onTap: () => _inputOperator('+')),
            const Expanded(child: SizedBox()),
          ]),
        ],
      ),
    );
  }
}