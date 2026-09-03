void main() {
  int marks = 75;

  if (marks >= 90) {
    print('Grade: A');
  } else if (marks >= 75) {
    print('Grade: B');
  } else if (marks >= 50) {
    print('Grade: C');
  } else {
    print('Grade: F');
  }

  String day = 'Monday';
  switch (day) {
    case 'Monday':
      print('Start of the work week');
      break;
    case 'Saturday':
    case 'Sunday':
      print('Weekend');
      break;
    default:
      print('Midweek');
  }
}