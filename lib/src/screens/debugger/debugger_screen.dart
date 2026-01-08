import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../shared/ui/theme.dart';

class DebuggerScreen extends StatefulWidget {
  const DebuggerScreen({super.key});

  @override
  State<DebuggerScreen> createState() => _DebuggerScreenState();
}

class _DebuggerScreenState extends State<DebuggerScreen> {
  // --- Inspectable Data Structures ---
  final List<Person> _people = [];
  final Map<String, dynamic> _complexMap = {
    'config': {
      'version': 1.0,
      'features': ['fast', 'secure', 'modern'],
    },
    'metadata': {'cratedAt': DateTime.now().toIso8601String()},
  };
  final Set<String> _uniqueIds = {};
  final LinkedList<CustomEntry> _linkedList = LinkedList<CustomEntry>();

  Node? _binaryTreeRoot;

  Timer? _tickerTimer;
  int _tickerSeconds = 0;

  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _startTicker();
  }

  @override
  void dispose() {
    _tickerTimer?.cancel();
    super.dispose();
  }

  void _startTicker() {
    _tickerTimer = Timer.periodic(const Duration(seconds: 1), _onTick);
  }

  void _onTick(Timer timer) {
    setState(() {
      _tickerSeconds++;
    });
    // PLACE BREAKPOINT HERE to evaluate the code in the DevTools debugger
    //
    debugPrint('Ticker tick: $_tickerSeconds');
  }

  void _initializeData() {
    // Populate heavy data for inspection
    for (int i = 0; i < 5; i++) {
      _people.add(
        Person(
          name: 'User $i',
          age: 20 + i,
          attributes: {'role': i % 2 == 0 ? 'Admin' : 'User'},
        ),
      );
    }

    _uniqueIds.addAll(['ID-A', 'ID-B', 'ID-C']);

    _linkedList.addAll([CustomEntry(100), CustomEntry(200), CustomEntry(300)]);

    _binaryTreeRoot = Node(
      id: 1,
      left: Node(id: 2, left: Node(id: 4), right: Node(id: 5)),
      right: Node(id: 3, right: Node(id: 6)),
    );
  }

  void _addPerson() {
    setState(() {
      _people.add(Person(name: 'New User $_counter', age: 10 + _counter));
      _counter++;
    });
  }

  void _modifyMap() {
    setState(() {
      _complexMap['update_$_counter'] = Random().nextInt(1000);
      (_complexMap['config'] as Map)['last_updated'] = DateTime.now();
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(largeSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Debugger Object Zoo',
            style: ShadTheme.of(context).textTheme.h3,
          ),
          Text(
            'Use Flutter DevTools "Debugger" to inspect these objects.',
            style: ShadTheme.of(context).textTheme.p,
          ),
          const SizedBox(height: largeSpacing),
          ShadCard(
            title: const Text('Breakpoint Target'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ticker Running: $_tickerSeconds s',
                  style: const TextStyle(
                    fontFamily: 'RobotoMono',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: denseSpacing),
                const Text(
                  'Instructions: Open DevTools Debugger and place a breakpoint inside the "_onTick" method in debugger_screen.dart to pause execution repeatedly.',
                ),
              ],
            ),
          ),
          const SizedBox(height: largeSpacing),
          ShadCard(
            title: const Text('Data Mutations'),
            child: Wrap(
              spacing: denseSpacing,
              runSpacing: denseSpacing,
              children: [
                ShadButton.outline(
                  onPressed: _addPerson,
                  child: const Text('Add Person (List)'),
                ),
                ShadButton.outline(
                  onPressed: _modifyMap,
                  child: const Text('Modify Complex Map'),
                ),
                ShadButton.outline(
                  onPressed: () => setState(() {
                    _uniqueIds.add('ID-$_counter');
                    _counter++;
                  }),
                  child: const Text('AddTo Set'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- Custom Objects ---

class Person {
  Person({required this.name, required this.age, this.attributes});

  final String name;
  final int age;
  final Map<String, dynamic>? attributes;
  final List<Person> friends = [];

  @override
  String toString() => '$name ($age)';
}

class Node {
  Node({required this.id, this.left, this.right});

  final int id;
  Node? left;
  Node? right;
}

base class CustomEntry extends LinkedListEntry<CustomEntry> {
  CustomEntry(this.value);
  final int value;

  @override
  String toString() => 'Entry($value)';
}
