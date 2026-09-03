class Animal {
  String name;
  Animal(this.name);

  void makeSound() {
    print('$name makes a sound');
  }
}

class Dog extends Animal {
  Dog(String name) : super(name);

  @override
  void makeSound() {
    print('$name barks');
  }
}

void main() {
  var animal = Animal('Generic Animal');
  var dog = Dog('Rex');

  animal.makeSound();
  dog.makeSound();
}