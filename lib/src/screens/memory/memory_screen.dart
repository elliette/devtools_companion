import 'dart:async';
import 'dart:isolate';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../shared/ui/theme.dart';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

void _generateObjectsIsolate(Map<String, dynamic> args) async {
  final sendPort = args['sendPort'] as SendPort;
  final objectCount = args['objectCount'] as int;
  final minSize = args['minSize'] as int;
  final maxSize = args['maxSize'] as int;
  final random = Random();
  final allocatedObjects = <String>[];
  final stopwatch = Stopwatch()..start();

  for (var i = 0; i < objectCount; i++) {
    final length = random.nextInt(maxSize - minSize + 1) + minSize;
    final randomString = String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(random.nextInt(_chars.length)),
      ),
    );

    allocatedObjects.add(randomString);
    if (stopwatch.elapsedMilliseconds > 50) {
      sendPort.send({'type': 'progress', 'count': i + 1});
      await Future.delayed(Duration.zero);
      stopwatch.reset();
    }
  }
  sendPort.send({'type': 'complete', 'data': allocatedObjects});
}

class MemoryScreen extends StatefulWidget {
  const MemoryScreen({super.key});

  @override
  State<MemoryScreen> createState() => _MemoryScreenState();
}

class _MemoryScreenState extends State<MemoryScreen> {
  late final TextEditingController _objectCountController;
  late final TextEditingController _minSizeController;
  late final TextEditingController _maxSizeController;
  final _allocatedObjects = <String>[];
  bool _isGenerating = false;
  int _generationProgress = 0;
  Isolate? _isolate;
  ReceivePort? _receivePort;

  @override
  void initState() {
    super.initState();
    _objectCountController = TextEditingController(text: '100000');
    _minSizeController = TextEditingController(text: '1000');
    _maxSizeController = TextEditingController(text: '100000');
  }

  @override
  void dispose() {
    _objectCountController.dispose();
    _minSizeController.dispose();
    _maxSizeController.dispose();
    _isolate?.kill(priority: Isolate.immediate);
    _receivePort?.close();
    super.dispose();
  }

  Future<void> _allocateObjects() async {
    setState(() {
      _isGenerating = true;
      _generationProgress = 0;
    });

    final objectCount = int.tryParse(_objectCountController.text) ?? 100000;
    final minSize = int.tryParse(_minSizeController.text) ?? 1000;
    final maxSize = int.tryParse(_maxSizeController.text) ?? 100000;

    if (minSize > maxSize) {
      ShadToaster.of(context).show(
        const ShadToast(
          title: Text('Error'),
          description: Text('Min size cannot be greater than max size.'),
        ),
      );
      setState(() {
        _isGenerating = false;
      });
      return;
    }

    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn(_generateObjectsIsolate, {
      'sendPort': _receivePort!.sendPort,
      'objectCount': objectCount,
      'minSize': minSize,
      'maxSize': maxSize,
    });

    _receivePort!.listen((message) {
      if (message is Map) {
        switch (message['type']) {
          case 'progress':
            setState(() {
              _generationProgress = message['count'] as int;
            });
            break;
          case 'complete':
            final newObjects = message['data'] as List<String>;
            _allocatedObjects.addAll(newObjects);
            ShadToaster.of(context).show(
              ShadToast(
                description: Text(
                  'Allocated ${newObjects.length} new string objects.',
                ),
              ),
            );
            _stopGeneration();
            break;
        }
      }
    });
  }

  void _stopGeneration() {
    _isolate?.kill(priority: Isolate.immediate);
    _receivePort?.close();
    setState(() {
      _isolate = null;
      _receivePort = null;
      _isGenerating = false;
      _generationProgress = 0;
    });
  }

  void _clearObjects() {
    _allocatedObjects.clear();
    setState(() {});
    ShadToaster.of(context).show(
      const ShadToast(
        description: Text('Cleared allocated objects. Ready for GC.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 350),
          child: Column(
            children: [
              ShadCard(
                title: const Text('Memory Tools'),
                description: Text(
                  _isGenerating
                      ? 'Generating objects... $_generationProgress so far.'
                      : 'Use these tools to test memory management in your application.\n'
                        'Currently holding onto ${_allocatedObjects.length} string objects.',
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_isGenerating) ...[
                      const ShadProgress(),
                      const Padding(
                        padding: EdgeInsets.all(defaultSpacing),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(defaultSpacing),
                      ),
                      ShadButton.destructive(
                        onPressed: _stopGeneration,
                        child: const Text('Stop Generation'),
                      ),
                    ] else ...[
                      ShadButton(
                        onPressed: _allocateObjects,
                        child: const Text('Allocate Objects'),
                      ),
                    ],
                    const Padding(
                      padding: EdgeInsets.all(defaultSpacing),
                    ),
                    ShadInputFormField(
                      controller: _objectCountController,
                      label: const Text('Number of Objects'),
                      keyboardType: TextInputType.number,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(defaultSpacing),
                    ),
                    ShadInputFormField(
                      controller: _minSizeController,
                      label: const Text('Min String Size'),
                      keyboardType: TextInputType.number,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(defaultSpacing),
                    ),
                    ShadInputFormField(
                      controller: _maxSizeController,
                      label: const Text('Max String Size'),
                      keyboardType: TextInputType.number,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(defaultSpacing),
                    ),
                    ShadButton.destructive(
                      onPressed: _clearObjects,
                      child: const Text('Clear Allocated Objects'),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(defaultSpacing),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
