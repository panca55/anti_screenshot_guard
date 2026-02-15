// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:anti_screenshot_guard/anti_screenshot_guard.dart';

void main() {
  testWidgets('SecureScreen renders child widget', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: SecureScreen(
          child: Text('Test Content'),
        ),
      ),
    );

    // Verify that the child widget is rendered
    expect(find.text('Test Content'), findsOneWidget);
  });
}
