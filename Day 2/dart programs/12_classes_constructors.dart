class Person {
  String name;
  int age;

  // Default constructor
  Person(this.name, this.age);

  // Named constructor
  Person.guest() : name = 'Guest', age = 0;

  // Factory constructor - can return existing instance or subtype
  factory Person.fromMap(Map<String, dynamic> data) {
    return Person(data['name'], data['age']);
  }

  void introduce() {
    print('Hi, I\'m $name, age $age');
  }
}

void main() {
  var p1 = Person('Razi', 24);
  var p2 = Person.guest();
  var p3 = Person.fromMap({'name': 'Alex', 'age': 22});

  p1.introduce();
  p2.introduce();
  p3.introduce();
}