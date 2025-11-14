import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../shared/ui/theme.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key, required this.screenName});

  final String screenName;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(denseSpacing),
          child: ShadCard(
            child: Text.rich(
              TextSpan(
                style: theme.textTheme.p,
                children: [
                  TextSpan(
                    text: 'TODO:',
                    style: theme.textTheme.p.copyWith(
                      backgroundColor: isDarkMode
                          ? Colors.purple
                          : Colors.yellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        ' Modify this screen to trigger useful actions for developers working on the DevTools $screenName panel.\n\n',
                  ),
                  const TextSpan(
                    text: 'For style consistency, please use widgets from ',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const TextSpan(
                    text: 'package:shadcn_ui',
                    style: TextStyle(fontFamily: 'RobotoMono'),
                  ),
                  const TextSpan(
                    text: ' whenever possible.\n',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: extraLargeSpacing),
          child: ShadButton.outline(
            child: const Text('Click me!'),
            onPressed: () {
              ShadToaster.of(context).show(
                ShadToast(
                  description: Text('Welcome to the companion tool for the DevTools $screenName Panel!'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
