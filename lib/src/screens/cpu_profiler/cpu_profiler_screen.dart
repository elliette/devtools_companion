import 'dart:isolate';

import 'package:flutter/material.dart';

import '../../shared/ui/theme.dart';
import 'expensive_task_widget.dart';
import 'party_poppers.dart';

class CpuProfilerScreen extends StatefulWidget {
  const CpuProfilerScreen({super.key});

  @override
  State<CpuProfilerScreen> createState() => _CpuProfilerScreenState();
}

class _CpuProfilerScreenState extends State<CpuProfilerScreen> {
  final _partyPopperController = PartyPopperController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const .all(largePadding),
      children: [
        const ExpensiveTaskWidget(
          title: 'Compute Fibonacci (37)',
          task: runFib37,
        ),
        ExpensiveTaskWidget(
          title: 'Compute Fibonacci (37) in Isolate',
          task: () => Isolate.run(runFib37),
        ),
        ExpensiveTaskWidget(
          title: 'Create 100 Party Poppers',
          children: [PartyPopperManager(controller: _partyPopperController)],
          task: () async {
            await _partyPopperController.start(100);
            return 'Hooray!';
          },
        ),
      ],
    );
  }
}

String runFib37() => _fib(37).toString();

int _fib(int n) {
  if (n <= 1) return n;
  return _fib(n - 1) + _fib(n - 2);
}
