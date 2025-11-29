import 'dart:async';

import 'package:devtools_companion/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

Future<void> _pumpUntil(
  WidgetTester tester,
  bool Function() condition, {
  Duration timeout = const Duration(seconds: 20),
  Duration step = const Duration(milliseconds: 100),
}) async {
  final end = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(end)) {
    await tester.pump(step);
    if (condition()) return;
  }
  fail('Condition not met within ${timeout.inSeconds}s');
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('allocates objects and reports the count', (tester) async {
    Future<void> enterField(String key, String value) async {
      final editable = find.descendant(
        of: find.byKey(ValueKey(key)),
        matching: find.byType(EditableText),
      );
      await tester.tap(editable);
      await tester.enterText(editable, value);
      await tester.pumpAndSettle();
    }

    app.main();
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Memory'));
    await tester.pumpAndSettle();

    await enterField('numberOfObjectsField', '555');
    await enterField('minStringSizeField', '1');
    await enterField('maxStringSizeField', '1');

    await tester.tap(find.text('Allocate Objects'));
    await tester.pump();

    const expectedDescription =
        'Use these tools to test memory management in your application.\n'
        'Currently holding onto 555 string objects.';

    await _pumpUntil(
      tester,
      () => find.text(expectedDescription).evaluate().isNotEmpty,
    );
    expect(find.text(expectedDescription), findsOneWidget);

    await tester.tap(find.text('Clear Allocated Objects'));
    await tester.pump();

    const clearedDescription =
        'Use these tools to test memory management in your application.\n'
        'Currently holding onto 0 string objects.';

    await _pumpUntil(
      tester,
      () => find.text(clearedDescription).evaluate().isNotEmpty,
    );
    expect(find.text(clearedDescription), findsOneWidget);
  });
}
