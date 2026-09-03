// Abstract class - cannot be instantiated directly
abstract class Shape {
  double calculateArea();
  void describe() {
    print('This shape has an area of ${calculateArea()}');
  }
}

class Circle extends Shape {
  double radius;
  Circle(this.radius);

  @override
  double calculateArea() => 3.14159 * radius * radius;
}

class Square extends Shape {
  double side;
  Square(this.side);

  @override
  double calculateArea() => side * side;
}

void main() {
  Circle c = Circle(5);
  Square s = Square(4);

  c.describe();
  s.describe();
}