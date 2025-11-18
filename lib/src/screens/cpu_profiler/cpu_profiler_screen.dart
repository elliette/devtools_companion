import 'dart:isolate';

import 'package:flutter/material.dart';

import '../../shared/ui/theme.dart';
import 'expensive_task_widget.dart';

class CpuProfilerScreen extends StatelessWidget {
  const CpuProfilerScreen({super.key});

  int _fib(int n) {
    if (n <= 1) return n;
    return _fib(n - 1) + _fib(n - 2);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const .all(largePadding),
      children: [
        ExpensiveTaskWidget(
          title: 'Compute Fibonacci (37)',
          task: () => _fib(37).toString(),
        ),
        ExpensiveTaskWidget(
          title: 'Compute Fibonacci (37) in Isolate',
          task: () => Isolate.run(() => _fib(37).toString()),
        ),
      ],
    );
  }
}
