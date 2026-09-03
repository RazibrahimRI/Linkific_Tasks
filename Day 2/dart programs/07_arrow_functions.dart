// Arrow function syntax - shorthand for single-expression functions
int square(int x) => x * x;
bool isEven(int x) => x % 2 == 0;
String fullName(String first, String last) => '$first $last';

void main() {
  print(square(5));
  print(isEven(4));
  print(fullName('Razi', 'Ibrahim'));
}