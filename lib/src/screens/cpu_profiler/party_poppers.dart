import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PartyPopperController {
  _PartyPopperManagerState? _state;

  void _attach(_PartyPopperManagerState state) {
    _state = state;
  }

  void _detach() {
    _state = null;
  }

  Future<void> start(int count) async {
    if (_state != null) {
      await _state!.addPoppers(count);
    }
  }
}

class PartyPopperManager extends StatefulWidget {
  const PartyPopperManager({super.key, required this.controller});

  final PartyPopperController controller;

  @override
  State<PartyPopperManager> createState() => _PartyPopperManagerState();
}

class _PartyPopperManagerState extends State<PartyPopperManager> {
  int _count = 0;
  int _runId = 0;
  List<Completer<void>> _completers = [];

  @override
  void initState() {
    super.initState();
    widget.controller._attach(this);
  }

  @override
  void didUpdateWidget(PartyPopperManager oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller._detach();
      widget.controller._attach(this);
    }
  }

  @override
  void dispose() {
    widget.controller._detach();
    for (final c in _completers) {
      if (!c.isCompleted) c.complete();
    }
    _completers = [];
    super.dispose();
  }

  Future<void> addPoppers(int count) async {
    if (!mounted) return;
    if (_completers.isNotEmpty) return;

    // Complete any previous run to avoid hanging
    for (final c in _completers) {
      if (!c.isCompleted) c.complete();
    }

    setState(() {
      _count = count;
      _runId++;
      _completers = List.generate(count, (_) => Completer<void>());
    });

    // Wait for all animations to complete
    await Future.wait(_completers.map((c) => c.future));
    if (!mounted) return;
    setState(() {
      _completers = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_completers.isEmpty) return const SizedBox.shrink();
    return Expanded(
      child: SizedBox(
        height: 300,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: List.generate(_count, (index) {
                final random = Random(index);
                return Positioned(
                  left: random.nextDouble() * constraints.maxWidth,
                  top: random.nextDouble() * constraints.maxHeight,
                  child: PartyPopper(
                    key: ValueKey('$_runId-$index'),
                    seed: index,
                    delay: Duration(milliseconds: index * 50),
                    onDone: () {
                      if (index < _completers.length &&
                          !_completers[index].isCompleted) {
                        _completers[index].complete();
                      }
                    },
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}

class PartyPopper extends StatefulWidget {
  const PartyPopper({
    super.key,
    this.seed = 0,
    this.delay = Duration.zero,
    this.onDone,
  });

  final int seed;
  final Duration delay;
  final VoidCallback? onDone;

  @override
  State<PartyPopper> createState() => _PartyPopperState();
}

class _PartyPopperState extends State<PartyPopper> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    if (widget.delay == Duration.zero) {
      _visible = true;
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) {
          setState(() {
            _visible = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_visible) return const SizedBox.shrink();

    return IgnorePointer(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Confetti
          ...List.generate(50, (index) {
            final random = Random(widget.seed * 1000 + index);
            final angle = pi + random.nextDouble() * pi;
            final distance = 100 + random.nextDouble() * 200;
            final color =
                Colors.primaries[random.nextInt(Colors.primaries.length)];

            return Positioned(
              child:
                  Container(
                        width: 2,
                        height: 2,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      )
                      .animate()
                      .move(
                        delay: 0.ms,
                        duration: 1500.ms,
                        begin: Offset.zero,
                        end: Offset(
                          cos(angle) * distance,
                          sin(angle) * distance,
                        ),
                        curve: Curves.easeOut,
                      )
                      .fadeOut(delay: 500.ms, duration: 500.ms),
            );
          }),
          const Text('🎉', style: TextStyle(fontSize: 16))
              .animate(onComplete: (controller) => widget.onDone?.call())
              .scale(duration: 500.ms, curve: Curves.elasticOut)
              .shake(delay: 500.ms, duration: 500.ms)
              .fadeOut(
                delay: 1000.ms,
                duration: 1000.ms,
                curve: Curves.elasticOut,
              ),
        ],
      ),
    );
  }
}
