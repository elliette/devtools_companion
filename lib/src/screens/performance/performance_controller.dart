import 'package:flutter/widgets.dart';

class PerformanceScreenController {
  PerformanceScreenController();
  final uiJankDurationMs = ValueNotifier(0.0);
  final rasterJankIntensity = ValueNotifier(0.0);

  void dispose() {
    uiJankDurationMs.dispose();
    rasterJankIntensity.dispose();
  }
}
