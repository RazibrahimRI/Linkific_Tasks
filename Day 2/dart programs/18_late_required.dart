class Config {
  late String apiKey; // initialized later, before first use

  void setApiKey(String key) {
    apiKey = key;
  }
}

class User {
  final String name;
  final int age;

  // required makes a named parameter mandatory
  User({required this.name, required this.age});
}

void main() {
  var config = Config();
  config.setApiKey('abc123');
  print('API Key: ${config.apiKey}');

  var user = User(name: 'Razi', age: 24);
  print('${user.name}, ${user.age}');
}