import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../shared/ui/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _readmeContent;

  @override
  void initState() {
    super.initState();
    unawaited(_loadReadme());
  }

  Future<void> _loadReadme() async {
    final content = await rootBundle.loadString('README.md');
    setState(() {
      _readmeContent = content;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(denseSpacing),
          child: ShadCard(
            child: _readmeContent == null
                ? const Center(child: ShadProgress())
                : Markdown(data: _readmeContent!, shrinkWrap: true),
          ),
        ),
      ],
    );
  }
}
