import 'package:flutter/widgets.dart';

import '../../shared/widgets/todo_screen.dart';

class NetworkScreen extends StatelessWidget {
  const NetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TodoScreen(screenName: 'Network');
  }
}
