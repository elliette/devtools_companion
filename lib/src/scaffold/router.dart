import 'package:flutter/material.dart';

import '../data/painting.dart';
import '../screens/cpu_profiler/cpu_profiler_screen.dart';
import '../screens/debugger/debugger_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/inspector/inspector_screen.dart';
import '../screens/logging/logging_screen.dart';
import '../screens/memory/memory_screen.dart';
import '../screens/network/network_screen.dart';
import '../screens/performance/performance_screen.dart';
import './app_shell.dart';

class AppRouter {
  static const String home = '/';
  static const String inspector = '/inspector';
  static const String performance = '/performance';
  static const String performanceDetails = '/performance/details';
  static const String network = '/network';
  static const String memory = '/memory';
  static const String cpuProfiler = '/cpu-profiler';
  static const String debugger = '/debugger';
  static const String logging = '/logging';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        switch (settings.name) {
          case inspector:
            return const AppShell(
                screenName: 'Inspector', screenBody: InspectorScreen());
          case performance:
            return const AppShell(
                screenName: 'Performance', screenBody: PerformanceScreen());
          case performanceDetails:
            final painting = settings.arguments as Painting;
            return AppShell(
              screenName: 'Performance',
              screenBody: PaintingDetailsScreen(painting: painting),
              showDrawer: false,
            );
          case network:
            return const AppShell(
                screenName: 'Network', screenBody: NetworkScreen());
          case memory:
            return const AppShell(
                screenName: 'Memory', screenBody: MemoryScreen());
          case cpuProfiler:
            return const AppShell(
                screenName: 'CPU Profiler', screenBody: CpuProfilerScreen());
          case debugger:
            return const AppShell(
                screenName: 'Debugger', screenBody: DebuggerScreen());
          case logging:
            return const AppShell(
                screenName: 'Logging', screenBody: LoggingScreen());
          case home:
          default:
            return const AppShell(screenName: 'Home', screenBody: HomeScreen());
        }
      },
    );
  }
}
