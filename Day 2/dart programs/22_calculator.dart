class Calculator {
  double add(double a, double b) => a + b;
  double subtract(double a, double b) => a - b;
  double multiply(double a, double b) => a * b;
  double divide(double a, double b) {
    if (b == 0) throw Exception('Cannot divide by zero');
    return a / b;
  }
}

void main() {
  var calc = Calculator();
  print('Add: ${calc.add(10, 5)}');
  print('Subtract: ${calc.subtract(10, 5)}');
  print('Multiply: ${calc.multiply(10, 5)}');
  print('Divide: ${calc.divide(10, 5)}');
}