import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'src/scaffold/router.dart';
import 'src/scaffold/theme_notifier.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const DevToolsCompanionApp(),
    ),
  );
}

class DevToolsCompanionApp extends StatefulWidget {
  const DevToolsCompanionApp({super.key});

  @override
  State<DevToolsCompanionApp> createState() => _DevToolsCompanionAppState();
}

class _DevToolsCompanionAppState extends State<DevToolsCompanionApp> {
  static const _primaryLight = Color.fromARGB(255, 25, 91, 184);
  static const _primaryDark = Color.fromARGB(255, 47, 131, 249);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) => ShadApp(
        title: 'DevTools Companion App',
        theme: ShadThemeData(
          brightness: Brightness.light,
          colorScheme: const ShadSlateColorScheme.light(primary: _primaryLight),
        ),
        darkTheme: ShadThemeData(
          brightness: Brightness.dark,
          colorScheme: const ShadSlateColorScheme.dark(primary: _primaryDark),
        ),
        themeMode: themeNotifier.themeMode,
        initialRoute: home,
        onGenerateRoute: onGenerateRoute,
        builder: (context, child) {
          return ShadToaster(child: child!);
        },
      ),
    );
  }
}
