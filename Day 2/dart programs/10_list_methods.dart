void main() {
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  // map - transform each element
  List<int> doubled = numbers.map((n) => n * 2).toList();
  print('Doubled: $doubled');

  // where - filter elements
  List<int> evens = numbers.where((n) => n % 2 == 0).toList();
  print('Evens: $evens');

  // reduce - combine into a single value
  int sum = numbers.reduce((a, b) => a + b);
  print('Sum: $sum');
}