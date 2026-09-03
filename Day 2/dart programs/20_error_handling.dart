Future<int> divideNumbers(int a, int b) async {
  if (b == 0) {
    throw Exception('Cannot divide by zero');
  }
  return a ~/ b;
}

void main() async {
  try {
    int result = await divideNumbers(10, 2);
    print('Result: $result');

    int errorResult = await divideNumbers(10, 0);
    print('Result: $errorResult');
  } catch (e) {
    print('Error caught: $e');
  } finally {
    print('Operation complete');
  }
}