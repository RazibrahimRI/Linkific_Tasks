import 'package:flutter_test/flutter_test.dart';
import 'package:testing_practice/calculator.dart';

void main() {
  late Calculator calc;

  setUp(() {
    calc = Calculator();
  });

  tearDown(() {
    calc.history.clear();
  });

  test('add', () => expect(calc.add(2, 3), 5));
  test('subtract', () => expect(calc.subtract(5, 3), 2));
  test('multiply', () => expect(calc.multiply(4, 3), 12));
  test('divide', () => expect(calc.divide(10, 2), 5));

  test('divide by zero throws', () {
    expect(() => calc.divide(1, 0), throwsArgumentError);
  });

  test('history records each operation', () {
    calc.add(1, 1);
    calc.multiply(2, 2);
    expect(calc.history.length, 2);
  });

  test('discountedPrice applies percent', () {
    expect(discountedPrice(200, 10), 180);
  });
}