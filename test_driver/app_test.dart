import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Scroll Performance', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('scroll list', () async {
      // Open drawer
      final drawerFinder = find.byTooltip('Open navigation menu');
      await driver.tap(drawerFinder);

      // Tap Performance
      final performanceFinder = find.text('Performance');
      await driver.tap(performanceFinder);

      // Wait for the list to render
      await Future.delayed(const Duration(seconds: 2));

      final listFinder = find.byType('ListView');

      // Warm up
      await driver.scroll(
        listFinder,
        0,
        -500,
        const Duration(milliseconds: 500),
      );
      await driver.scroll(
        listFinder,
        0,
        500,
        const Duration(milliseconds: 500),
      );

      final timeline = await driver.traceAction(() async {
        // Scroll down
        await driver.scroll(listFinder, 0, -2000, const Duration(seconds: 2));
        await Future.delayed(const Duration(milliseconds: 500));
        // Scroll up
        await driver.scroll(listFinder, 0, 2000, const Duration(seconds: 2));
      });

      final summary = TimelineSummary.summarize(timeline);
      // await summary.writeSummaryToFile('scrolling_benchmark', pretty: true);
      await summary.writeTimelineToFile('scrolling_benchmark', pretty: true);
    });
  });
}
