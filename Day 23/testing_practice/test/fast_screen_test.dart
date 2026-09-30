
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_practice/fast_screen.dart';

void main() {
  testWidgets('CounterSection increases when Add is tapped', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: CounterSection())),
    );

    expect(find.text('Counter: 0'), findsOneWidget);
    await tester.tap(find.text('Add'));
    await tester.pump();
    expect(find.text('Counter: 1'), findsOneWidget);
  });

  testWidgets('FastScreen list scrolls to the last item', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: FastScreen()));

    expect(find.text('Item 199'), findsNothing);   // not built yet

    await tester.dragUntilVisible(                  // scroll
      find.text('Item 199'),
      find.byType(ListView),
      const Offset(0, -500),
    );

    expect(find.text('Item 199'), findsOneWidget);
  });
}