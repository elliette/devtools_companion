import 'package:flutter/material.dart';

import '../screens/cpu_profiler/cpu_profiler_screen.dart';
import '../screens/debugger/debugger_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/inspector/inspector_screen.dart';
import '../screens/logging/logging_screen.dart';
import '../screens/memory/memory_screen.dart';
import '../screens/network/network_screen.dart';
import '../screens/performance/data/fruits.dart';
import '../screens/performance/fruit_details.dart';
import '../screens/performance/performance_screen.dart';
import '../screens/timeline/timeline_screen.dart';
import './app_shell.dart';

enum AppRoute {
  home(name: 'Home', path: '/', iconAsset: 'assets/icons/devtools.png'),
  inspector(
    name: 'Inspector',
    path: '/inspector',
    iconAsset: 'assets/icons/inspector.png',
  ),
  performance(
    name: 'Performance',
    path: '/performance',
    iconAsset: 'assets/icons/performance.png',
  ),
  performanceDetails(
    name: 'Performance Details',
    path: '/performance/details',
    iconAsset: 'assets/icons/performance.png',
    showInAppDrawer: false,
  ),
  timeline(
    name: 'Timeline',
    path: '/timeline',
    // TODO: Choose a different icon.
    iconAsset: 'assets/icons/debugger.png',
  ),
  network(
    name: 'Network',
    path: '/network',
    iconAsset: 'assets/icons/network.png',
  ),
  memory(name: 'Memory', path: '/memory', iconAsset: 'assets/icons/memory.png'),
  cpuProfiler(
    name: 'CPU Profiler',
    path: '/cpu-profiler',
    iconAsset: 'assets/icons/cpu_profiler.png',
  ),
  debugger(
    name: 'Debugger',
    path: '/debugger',
    iconAsset: 'assets/icons/debugger.png',
  ),
  logging(
    name: 'Logging',
    path: '/logging',
    iconAsset: 'assets/icons/logging.png',
  );

  const AppRoute({
    required this.name,
    required this.path,
    required this.iconAsset,
    this.showInAppDrawer = true,
  });
  final String path;
  final String name;
  final String iconAsset;
  final bool showInAppDrawer;

  static AppRoute fromPath(String? path) {
    if (path == null) return AppRoute.home;
    return AppRoute.values.firstWhere(
      (e) => e.path == path,
      orElse: () => AppRoute.home,
    );
  }
}

String get home => AppRoute.home.path;

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  final page = AppRoute.fromPath(settings.name);
  return MaterialPageRoute(
    settings: settings,
    builder: (context) {
      switch (page) {
        case AppRoute.inspector:
          return const AppShell(
            screenName: 'Inspector',
            screenBody: InspectorScreen(),
          );
        case AppRoute.performance:
          return const AppShell(
            screenName: 'Performance',
            screenBody: PerformanceScreen(),
          );
        case AppRoute.performanceDetails:
          final fruit = settings.arguments as Fruit;
          return AppShell(
            screenName: 'Performance',
            screenBody: FruitDetailsScreen(fruit: fruit),
            showDrawer: false,
          );
        case AppRoute.timeline:
          return const AppShell(
            screenName: 'Timeline',
            screenBody: TimelineScreen(),
          );
        case AppRoute.network:
          return const AppShell(
            screenName: 'Network',
            screenBody: NetworkScreen(),
          );
        case AppRoute.memory:
          return const AppShell(
            screenName: 'Memory',
            screenBody: MemoryScreen(),
          );
        case AppRoute.cpuProfiler:
          return const AppShell(
            screenName: 'CPU Profiler',
            screenBody: CpuProfilerScreen(),
          );
        case AppRoute.debugger:
          return const AppShell(
            screenName: 'Debugger',
            screenBody: DebuggerScreen(),
          );
        case AppRoute.logging:
          return const AppShell(
            screenName: 'Logging',
            screenBody: LoggingScreen(),
          );
        case AppRoute.home:
          return const AppShell(screenName: 'Home', screenBody: HomeScreen());
      }
    },
  );
}
