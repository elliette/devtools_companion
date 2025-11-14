import 'package:flutter/widgets.dart';

import '../../shared/widgets/todo_screen.dart';

class InspectorScreen extends StatelessWidget {
  const InspectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TodoScreen(screenName: 'Inspector');
  }
}