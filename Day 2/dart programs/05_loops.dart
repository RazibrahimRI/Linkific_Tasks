void main() {
  // for loop
  for (int i = 1; i <= 5; i++) {
    print('For loop: $i');
  }

  // while loop
  int count = 0;
  while (count < 3) {
    print('While loop: $count');
    count++;
  }

  // forEach loop
  List<String> tools = ['Flutter', 'Dart', 'Firebase'];
  tools.forEach((tool) {
    print('Tool: $tool');
  });
}