import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../shared/ui/theme.dart';
import 'data/fruits.dart';

class FruitDetailsScreen extends StatelessWidget {
  const FruitDetailsScreen({super.key, required this.fruit});

  final Fruit fruit;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Padding(
      padding: const EdgeInsets.all(defaultSpacing),
      child: ShadCard(
        backgroundColor: theme.colorScheme.secondary,
        padding: const EdgeInsets.all(noPadding),
        footer: Padding(
          padding: const EdgeInsets.symmetric(vertical: densePadding),
          child: Center(
            child: Text(
              fruit.title,
              style: theme.textTheme.p.copyWith(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        child: Image.asset(fruit.imageUrl),
      ),
    );
  }
}
