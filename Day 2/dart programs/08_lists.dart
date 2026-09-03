void main() {
  List<String> languages = ['Dart', 'Python', 'JavaScript'];

  print(languages);
  print('First: ${languages[0]}');
  print('Length: ${languages.length}');

  languages.add('Kotlin');
  print('After add: $languages');

  languages.remove('Python');
  print('After remove: $languages');

  languages.sort();
  print('Sorted: $languages');
}