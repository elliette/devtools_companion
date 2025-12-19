import 'dart:developer';

import 'package:flutter/widgets.dart';

import '../../shared/ui/theme.dart';
import '../../shared/widgets/expensive_task_widget.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const .all(largePadding),
      children: [
        ExpensiveTaskWidget(
          title: 'Compute Fibonacci (32)',
          task: () => _fib(32).toString(),
        ),
        ExpensiveTaskWidget(
          title: 'Compute Fibonacci async (24)',
          task: () async => (await _fibAsync(24)).toString(),
        ),
        // TODO: Something with `Timeline.instant`.
        // TODO: Something with passing a TimelineTask to a different Isolate.
      ],
    );
  }
}

Future<int> _fibAsync(int n, {TimelineTask? parent}) async {
  final task = TimelineTask(parent: parent)..start('Fib $n');
  if (n <= 1) {
    // TODO: Something with `arguments` here? Do they show up in DevTools?
    task.finish();
    return n;
  }
  await Future.delayed(const Duration(milliseconds: 16));
  final (a, b) = await (
    _fibAsync(n - 1, parent: task),
    _fibAsync(n - 2, parent: task),
  ).wait;
  final result = a + b;

  task.finish();
  return result;
}

int _fib(int n) {
  Timeline.startSync('Fib $n');
  if (n <= 1) {
    Timeline.finishSync();
    return n;
  }
  final result = _fib(n - 1) + _fib(n - 2);
  Timeline.finishSync();
  return result;
}
