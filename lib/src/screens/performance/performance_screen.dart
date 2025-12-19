import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../shared/ui/theme.dart';
import 'fruit_list.dart';
import 'performance_controller.dart';
import 'performance_saboteur.dart';
import 'performance_settings.dart';

class PerformanceScreen extends StatefulWidget {
  const PerformanceScreen({super.key});

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  late final PerformanceScreenController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PerformanceScreenController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Fruits & Veggies', style: theme.textTheme.h2),
                  JankSettingsPopover(controller: _controller),
                ],
              ),
            ),
            const Expanded(child: FruitsList()),
          ],
        ),
        ValueListenableBuilder(
          valueListenable: _controller.rasterJankIntensity,
          builder: (context, value, child) =>
              RasterThreadSaboteur(intensity: value.round()),
        ),
        ValueListenableBuilder(
          valueListenable: _controller.uiJankDurationMs,
          builder: (context, value, child) =>
              UiThreadSaboteur(jankMs: value.round()),
        ),
      ],
    );
  }
}
