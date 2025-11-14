import 'package:flutter/widgets.dart';

import '../../shared/widgets/todo_screen.dart';

class LoggingScreen extends StatelessWidget {
  const LoggingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TodoScreen(screenName: 'Logging');
  }
}