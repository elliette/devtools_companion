import 'dart:async';
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
          title: 'Compute FibonacciAsync (20) x5',
          task: () async {
            final results = await Future.wait([
              for (var i = 0; i < 5; i++) fibAsync20(),
            ]);
            return '${results.reduce((a, b) => a + b)}';
          },
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

Future<int> fibAsync20() => _fibAsync(20);

Future<int> _fibAsync(int n) async {
  if (n <= 1) return n;
  await Future.delayed(const Duration(milliseconds: 16));
  final (a, b) = await (_fibAsync(n - 1), _fibAsync(n - 2)).wait;
  return a + b;
}

String runFib37() => _fib(37).toString();

int _fib(int n) {
  if (n <= 1) return n;
  return _fib(n - 1) + _fib(n - 2);
}
