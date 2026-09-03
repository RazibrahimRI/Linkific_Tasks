void main() {
  int a = 10;
  int b = 3;

  // Arithmetic operators
  print('Addition: ${a + b}');
  print('Subtraction: ${a - b}');
  print('Multiplication: ${a * b}');
  print('Division: ${a / b}');
  print('Integer Division: ${a ~/ b}');
  print('Modulus: ${a % b}');

  // Comparison operators
  print('Equal: ${a == b}');
  print('Not Equal: ${a != b}');
  print('Greater than: ${a > b}');
  print('Less than: ${a < b}');

  // Logical operators
  bool isAdult = true;
  bool hasLicense = false;

  print('AND: ${isAdult && hasLicense}');
  print('OR: ${isAdult || hasLicense}');
  print('NOT: ${!isAdult}');
}