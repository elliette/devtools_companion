import 'package:flutter/widgets.dart';

import '../../shared/widgets/todo_screen.dart';

class PerformanceScreen extends StatelessWidget {
  const PerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TodoScreen(screenName: 'Performance');
  }
}