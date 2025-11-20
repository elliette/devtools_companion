import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class RasterThreadSaboteur extends StatelessWidget {
  const RasterThreadSaboteur({super.key, required this.intensity});

  final int intensity;

  @override
  Widget build(BuildContext context) {
    if (intensity == 0) return const SizedBox.shrink();

    Widget child = const SizedBox.shrink();

    for (int i = 0; i < intensity * 5; i++) {
      child = Stack(
        fit: StackFit.expand,
        children: [
          child,
          // Opacity + Clip + Blur = Expensive Rasterization
          Opacity(
            opacity: 0.01,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(color: Colors.white.withAlpha(10)),
              ),
            ),
          ),
        ],
      );
    }

    // Make it invisible.
    return Positioned.fill(child: IgnorePointer(child: child));
  }
}

class UiThreadSaboteur extends StatefulWidget {
  const UiThreadSaboteur({super.key, required this.jankMs});
  final int jankMs;

  @override
  State<UiThreadSaboteur> createState() => _UiThreadSaboteurState();
}

class _UiThreadSaboteurState extends State<UiThreadSaboteur>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((_) => _induceJank());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateTickerState();
  }

  @override
  void didUpdateWidget(covariant UiThreadSaboteur oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.jankMs != widget.jankMs) {
      _updateTickerState();
    }
  }

  void _updateTickerState() {
    final shouldRun = TickerMode.of(context) && widget.jankMs > 0;
    if (shouldRun && !_ticker.isActive) {
      unawaited(_ticker.start());
    } else if (!shouldRun && _ticker.isActive) {
      _ticker.stop();
    }
  }

  void _induceJank() {
    final stallMs = widget.jankMs;
    if (stallMs <= 0) return;

    final stopwatch = Stopwatch()..start();
    while (stopwatch.elapsedMilliseconds < stallMs) {
      // This busy-wait loop intentionally blocks the UI thread to induce jank.
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
