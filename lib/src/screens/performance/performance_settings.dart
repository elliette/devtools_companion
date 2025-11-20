import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../shared/ui/theme.dart';
import 'performance_controller.dart';

class JankSettingsPopover extends StatefulWidget {
  const JankSettingsPopover({super.key, required this.controller});

  final PerformanceScreenController controller;
  @override
  State<JankSettingsPopover> createState() => _JankSettingsPopoverState();
}

class _JankSettingsPopoverState extends State<JankSettingsPopover> {
  final popoverController = ShadPopoverController();

  @override
  void dispose() {
    popoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadPopover(
      controller: popoverController,
      popover: (context) => JankSettings(
        popoverController: popoverController,
        controller: widget.controller,
      ),
      child: ShadButton.outline(
        onPressed: popoverController.toggle,
        child: const Text('Jank Controls'),
      ),
    );
  }
}

class JankSettings extends StatefulWidget {
  const JankSettings({
    super.key,
    required this.popoverController,
    required this.controller,
  });

  final ShadPopoverController popoverController;
  final PerformanceScreenController controller;

  @override
  State<JankSettings> createState() => _JankSettingsState();
}

class _JankSettingsState extends State<JankSettings> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 350),
      child: Padding(
        padding: const EdgeInsets.only(top: defaultSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('UI Jank:'),
            ValueListenableBuilder(
              valueListenable: widget.controller.uiJankDurationMs,
              builder: (context, value, child) {
                return Slider(
                  value: value,
                  max: 50,
                  divisions: 10,
                  label: 'UI Jank Stall (${value.round()}ms)',
                  onChanged: (v) =>
                      widget.controller.uiJankDurationMs.value = v,
                );
              },
            ),
            const Text('Raster Jank:'),
            ValueListenableBuilder(
              valueListenable: widget.controller.rasterJankIntensity,
              builder: (context, value, child) {
                return Slider(
                  value: value,
                  max: 10,
                  divisions: 10,
                  label: 'Raster Jank Intensity (${value.round()})',
                  onChanged: (v) =>
                      widget.controller.rasterJankIntensity.value = v,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
