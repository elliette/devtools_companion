import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:devtools_companion/src/scaffold/router.dart';

import '../../data/painting.dart';
import '../../shared/ui/theme.dart';
import 'data/paintings.dart';

class PerformanceScreenController {
  PerformanceScreenController();
  final cpuJank = ValueNotifier<bool>(false);

  void dispose() {
    cpuJank.dispose();
  }
}
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Cezanne gallery', style: theme.textTheme.h2),
            SettingsPopover(controller: _controller),
          ],
        ),
        Expanded(child: PaintingsList(controller: _controller)),
      ],
    );
  }
}

class SettingsForm extends StatefulWidget {
  const SettingsForm({
    super.key,
    required this.popoverController,
    required this.controller,
  });

  final ShadPopoverController popoverController;
  final PerformanceScreenController controller;

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final formKey = GlobalKey<ShadFormState>();

  @override
  Widget build(BuildContext context) {
    return ShadForm(
      key: formKey,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 350),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            ShadSwitchFormField(
              id: 'cpu_jank',
              initialValue: widget.controller.cpuJank.value,
              inputLabel: const Text('CPU Jank'),
              onChanged: (v) => widget.controller.cpuJank.value = v,
              inputSublabel: const Text(
                'Decodes paintings JSON in build method.',
              ),
            ),
            const SizedBox(height: 16),
            ShadButton(
              size: ShadButtonSize.sm,
              child: const Text('Submit'),
              onPressed: () {
                formKey.currentState?.fields.entries.forEach((entry) => print('${entry.key} - ${entry.value.value}'));
                if (formKey.currentState!.saveAndValidate()) {
                  widget.popoverController.hide();
                } else {
                  print('validation failed');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPopover extends StatefulWidget {
  const SettingsPopover({
    super.key,
    required this.controller,
  });

  final PerformanceScreenController controller;
  @override
  State<SettingsPopover> createState() => _PopoverPageState();
}

class _PopoverPageState extends State<SettingsPopover> {
  final popoverController = ShadPopoverController();

  @override
  void dispose() {
    popoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = ShadTheme.of(context).textTheme;
    return ShadPopover(
      controller: popoverController,
      popover: (context) => SettingsForm(
        popoverController: popoverController,
        controller: widget.controller,
      ),
      child: ShadButton.outline(
        onPressed: popoverController.toggle,
        child: const Text('Settings'),
      ),
    );
  }
}

class PaintingsList extends StatefulWidget {
  const PaintingsList({super.key, required this.controller});

  final PerformanceScreenController controller;

  @override
  State<PaintingsList> createState() => _PaintingsListState();
}

class _PaintingsListState extends State<PaintingsList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.controller.cpuJank,
      builder: (context, cpuJank, child) {
        final paintings = cpuJank
            ? Painting.parsePaintingsJsonWithJank(paintingsDataStr)
            : Painting.parsePaintingsJson(paintingsDataStr);

        return ListView.builder(
          itemCount: paintings.length,
          itemBuilder: (context, index) {
            final painting = paintings[index];
            return Padding(
              padding: const EdgeInsets.all(densePadding),
              child: ListTile(
                onTap: () => Navigator.of(
                  context,
                ).pushNamed(AppRouter.performanceDetails, arguments: painting),
                leading: Image.network(painting.imageUrl, width: 100),
                title: Text(painting.title),
              ),
            );
          },
        );
      },
    );
  }
}

class PaintingDetailsScreen extends StatelessWidget {
  const PaintingDetailsScreen({super.key, required this.painting});

  final Painting painting;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(defaultSpacing),
      child: ShadCard(
        backgroundColor: theme.colorScheme.secondary,
        padding: const EdgeInsets.all(noPadding),
        footer: Padding(
          padding: const EdgeInsets.symmetric(vertical: densePadding),
          child: Center(
            child: Text(
              painting.title,
              style: theme.textTheme.p.copyWith(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        child: Image.network(painting.imageUrl),
      ),
    );
  }
}
