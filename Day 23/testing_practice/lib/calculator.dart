class Calculator {
  final List<String> history = [];

  double add(double a, double b) {
    history.add('add');
    return a + b;
  }

  double subtract(double a, double b) {
    history.add('subtract');
    return a - b;
  }

  double multiply(double a, double b) {
    history.add('multiply');
    return a * b;
  }

  double divide(double a, double b) {
    if (b == 0) throw ArgumentError('Cannot divide by zero');
    history.add('divide');
    return a / b;
  }
}

// business logic
double discountedPrice(double price, int percent) {
  if (price < 0 || percent < 0 || percent > 100) {
    throw ArgumentError('Invalid price or percent');
  }
  return price - price * percent / 100;
}