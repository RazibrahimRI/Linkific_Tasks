import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_practice/basics_screen.dart';

void main() {
  testWidgets('renders title, count and button', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: BasicsScreen()));

    expect(find.text('Basics'), findsOneWidget);          // find.text
    expect(find.text('Count: 0'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);  // find.byType
  });

  testWidgets('tapping the button increases the count', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: BasicsScreen()));

    await tester.tap(find.text('Tap'));                   // tap
    await tester.pump();

    expect(find.text('Count: 1'), findsOneWidget);
  });
}