import 'dart:async';

import 'package:flutter/material.dart';

import '../ui/theme.dart';

class ExpensiveTaskWidget extends StatefulWidget {
  const ExpensiveTaskWidget({
    super.key,
    required this.title,
    required this.task,
    this.buttonText = 'Run',
    this.children,
  });

  final String title;
  final FutureOr<String> Function() task;
  final String buttonText;
  final List<Widget>? children;

  @override
  State<ExpensiveTaskWidget> createState() => _ExpensiveTaskWidgetState();
}

class _ExpensiveTaskWidgetState extends State<ExpensiveTaskWidget> {
  bool _isRunning = false;
  String? _result;
  Duration? _executionTime;

  Future<void> _runTask() async {
    setState(() {
      _isRunning = true;
      _result = null;
      _executionTime = null;
    });

    // Allow the UI to update to the loading state before blocking
    await Future.delayed(const Duration(milliseconds: 50));

    final stopwatch = Stopwatch()..start();
    try {
      final result = await widget.task();
      stopwatch.stop();
      if (mounted) {
        setState(() {
          _result = result;
          _executionTime = stopwatch.elapsed;
        });
      }
    } catch (e) {
      stopwatch.stop();
      if (mounted) {
        setState(() {
          _result = 'Error: $e';
          _executionTime = stopwatch.elapsed;
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isRunning = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const .all(denseSpacing),
      child: Padding(
        padding: const .all(largePadding),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(widget.title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: denseSpacing),
            Row(
              children: [
                if (_isRunning)
                  const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                else
                  FilledButton.icon(
                    onPressed: _runTask,
                    icon: const Icon(Icons.play_arrow),
                    label: Text(widget.buttonText),
                  ),
                const SizedBox(width: largeSpacing),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_executionTime != null)
                        Text(
                          'Duration: ${_executionTime!.inMilliseconds}ms',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      if (_result != null)
                        Text(
                          'Result: $_result',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            if (widget.children != null) ...[Row(children: widget.children!)],
          ],
        ),
      ),
    );
  }
}
