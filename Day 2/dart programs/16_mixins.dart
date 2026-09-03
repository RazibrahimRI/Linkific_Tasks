mixin Swimmer {
  void swim() => print('Swimming...');
}

mixin Flyer {
  void fly() => print('Flying...');
}

class Duck with Swimmer, Flyer {
  String name = 'Duck';
}

void main() {
  var duck = Duck();
  duck.swim();
  duck.fly();
}