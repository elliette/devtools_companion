import 'package:flutter/widgets.dart';

import '../../shared/widgets/todo_screen.dart';

class MemoryScreen extends StatelessWidget {
  const MemoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TodoScreen(screenName: 'Memory');
  }
}