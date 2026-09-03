void main() {
  // Set - unique values only
  Set<int> uniqueNumbers = {1, 2, 2, 3, 3, 4};
  print('Set: $uniqueNumbers');

  uniqueNumbers.add(5);
  uniqueNumbers.add(1); // duplicate, ignored
  print('After add: $uniqueNumbers');

  // Map - key-value pairs
  Map<String, int> scores = {
    'Razi': 85,
    'Alex': 90,
  };

  scores['Sam'] = 78;
  print('Map: $scores');
  print('Razi\'s score: ${scores['Razi']}');
}