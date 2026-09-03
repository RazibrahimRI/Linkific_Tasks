// Basic function with return type
int add(int a, int b) {
  return a + b;
}

// Function with optional named parameters
String greet(String name, {String greeting = 'Hello'}) {
  return '$greeting, $name!';
}

// Function with default value
double calculateArea(double length, double width) {
  return length * width;
}

void main() {
  print(add(5, 3));
  print(greet('Razi'));
  print(greet('Razi', greeting: 'Welcome'));
  print(calculateArea(4.0, 5.0));
}