import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.all(16.0),
      children: [
        ExpensiveTaskWidget(
          title: 'Compute Fibonacci (37)',
          task: () => _fib(37).toString(),
        ),
      ],
    );
  }
}
