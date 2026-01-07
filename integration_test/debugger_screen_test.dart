import 'package:devtools_companion/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Verify Debugger Screen elements', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Open Drawer and navigate to Debugger
    final drawerIconFinder = find.byTooltip('Open navigation menu');
    await tester.tap(drawerIconFinder);
    await tester.pumpAndSettle();

    final debuggerItemFinder = find.text('Debugger');
    // Ensure we tap the ListTile in the drawer
    await tester.tap(debuggerItemFinder.last);
    await tester.pumpAndSettle();

    // Verify Debugger Title
    expect(find.text('Debugger Object Zoo'), findsOneWidget);

    // Verify Data Mutation Controls
    expect(find.text('Add Person (List)'), findsOneWidget);
    expect(find.text('Modify Complex Map'), findsOneWidget);
    expect(find.text('AddTo Set'), findsOneWidget);

    // Click buttons to ensure no crashes
    await tester.tap(find.text('Add Person (List)'));
    await tester.pumpAndSettle();

    // Verify Widget Tree Section
    expect(find.text('Widget Tree Inspection Target'), findsOneWidget);
    // Values "Node Depth 1" should exist
    expect(find.text('Node Depth 1'), findsOneWidget);
    // Nested one
    expect(find.text('Node Depth 2'), findsAtLeastNWidgets(1));
  });
}
