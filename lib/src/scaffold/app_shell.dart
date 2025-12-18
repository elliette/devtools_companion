import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './app_drawer.dart';
import './theme_notifier.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.screenName,
    required this.screenBody,
    this.showDrawer = true,
  });

  final String screenName;
  final Widget screenBody;
  final bool showDrawer;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeNotifier.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(screenName),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              themeNotifier.toggleTheme();
            },
            tooltip: isDarkMode ? 'Light mode' : 'Dark mode',
          ),
        ],
      ),
      drawer: showDrawer ? const AppDrawer() : null,
      body: Center(child: screenBody),
    );
  }
}
