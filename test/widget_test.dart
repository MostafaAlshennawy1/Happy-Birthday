import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:happy_birthday/main.dart';

void main() {
  testWidgets('Birthday Screen UI and Make a Wish test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that 'Happy', 'Birthday', and default name 'Mostafa!' are found.
    expect(find.text('Happy'), findsOneWidget);
    expect(find.text('Birthday'), findsOneWidget);
    expect(find.text('Mostafa!'), findsOneWidget);

    // Verify that the 'Make a Wish!' button exists.
    expect(find.text('Make a Wish!'), findsOneWidget);

    // Tap the 'Make a Wish!' button.
    await tester.tap(find.text('Make a Wish!'));
    // Pump frames to allow the AnimatedSwitcher transition to complete (500ms duration).
    await tester.pump(const Duration(milliseconds: 600));

    // Verify that the blessing message is shown after making a wish.
    expect(find.text('✨ Your wish is my\ncommand! ✨'), findsOneWidget);
    expect(find.textContaining('May all your dreams come true, Mostafa!'), findsOneWidget);
  });
}
