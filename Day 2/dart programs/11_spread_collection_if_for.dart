void main() {
  List<int> first = [1, 2, 3];
  List<int> second = [4, 5, 6];

  // Spread operator - merges lists
  List<int> combined = [...first, ...second];
  print('Combined: $combined');

  bool includeExtra = true;
  List<int> withCondition = [
    1, 2, 3,
    if (includeExtra) 4, // collection if
  ];
  print('With condition: $withCondition');

  List<int> squares = [
    for (int i = 1; i <= 5; i++) i * i, // collection for
  ];
  print('Squares: $squares');
}