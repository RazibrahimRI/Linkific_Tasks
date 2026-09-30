import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_practice/login_form.dart';

void main() {
  test('validateEmail returns errors for bad input', () {
    expect(validateEmail(''), 'Email is required');
    expect(validateEmail('abc'), 'Enter a valid email');
    expect(validateEmail('a@b.com'), isNull);
  });

  testWidgets('form shows error, then accepts a valid email', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: LoginForm())),
    );

    await tester.tap(find.text('Submit'));
    await tester.pump();
    expect(find.text('Email is required'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'a@b.com');
    await tester.tap(find.text('Submit'));
    await tester.pump();
    expect(find.text('Submitted'), findsOneWidget);
  });
}