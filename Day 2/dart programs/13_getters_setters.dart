class Rectangle {
  double length;
  double width;

  Rectangle(this.length, this.width);

  // Getter - computed property
  double get area => length * width;

  // Setter - controlled assignment
  set setLength(double value) {
    if (value > 0) {
      length = value;
    } else {
      print('Length must be positive');
    }
  }
}

void main() {
  var rect = Rectangle(4, 5);
  print('Area: ${rect.area}');

  rect.setLength = 10;
  print('New area: ${rect.area}');

  rect.setLength = -5; // rejected by setter
}
