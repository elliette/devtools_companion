import 'package:flutter/widgets.dart';

import '../../shared/widgets/todo_screen.dart';

class CpuProfilerScreen extends StatelessWidget {
  const CpuProfilerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TodoScreen(screenName: 'CPU Profiler');
  }
}