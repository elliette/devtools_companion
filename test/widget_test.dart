import 'package:devtools_companion/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Basic test', (WidgetTester tester) async {
    await tester.pumpWidget(const DevToolsCompanionApp());
    expect(find.text('DevTools'), findsOneWidget);
  });
}
