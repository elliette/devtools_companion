import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../shared/ui/theme.dart';

final _log = Logger('devtools_companion');

class LoggingScreen extends StatefulWidget {
  const LoggingScreen({super.key});

  @override
  State<LoggingScreen> createState() => _LoggingScreenState();
}

class _LoggingScreenState extends State<LoggingScreen> {
  static const String _defaultText = 'Hello world!';

  late TextEditingController _finestController;
  late TextEditingController _finerController;
  late TextEditingController _fineController;
  late TextEditingController _configController;
  late TextEditingController _logController;
  late TextEditingController _warnController;
  late TextEditingController _severeController;
  late TextEditingController _shoutController;

  @override
  void initState() {
    super.initState();
    _finestController = TextEditingController(text: _defaultText);
    _finerController = TextEditingController(text: _defaultText);
    _fineController = TextEditingController(text: _defaultText);
    _configController = TextEditingController(text: _defaultText);
    _logController = TextEditingController(text: _defaultText);
    _warnController = TextEditingController(text: _defaultText);
    _severeController = TextEditingController(text: _defaultText);
    _shoutController = TextEditingController(text: _defaultText);
  }

  @override
  void dispose() {
    _finestController.dispose();
    _finerController.dispose();
    _fineController.dispose();
    _configController.dispose();
    _logController.dispose();
    _warnController.dispose();
    _severeController.dispose();
    _shoutController.dispose();
    super.dispose();
  }

  void _triggerFinestLog() {
    final message = _finestController.text;
    _log.finest(message);
    _showSnackBar('Finest log sent: $message');
  }

  void _triggerFinerLog() {
    final message = _finerController.text;
    _log.finer(message);
    _showSnackBar('Finer log sent: $message');
  }

  void _triggerFineLog() {
    final message = _fineController.text;
    _log.fine(message);
    _showSnackBar('Fine log sent: $message');
  }

  void _triggerConfigLog() {
    final message = _configController.text;
    _log.config(message);
    _showSnackBar('Config log sent: $message');
  }

  void _triggerInfoLog() {
    final message = _logController.text;
    _log.info(message);
    _showSnackBar('Info log sent: $message');
  }

  void _triggerWarningLog() {
    final message = _warnController.text;
    _log.warning(message);
    _showSnackBar('Warning log sent: $message');
  }

  void _triggerSevereLog() {
    final message = _severeController.text;
    _log.severe(message, Exception(message), StackTrace.current);
    _showSnackBar('Severe log sent: $message');
  }

  void _triggerShoutLog() {
    final message = _shoutController.text;
    _log.shout(message);
    _showSnackBar('Shout log sent: $message');
  }

  void _showSnackBar(String text) {
    final toast = ShadToast(
      description: Text(text),
      duration: const Duration(milliseconds: 1200),
    );
    ShadToaster.of(context).show(toast);
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Padding(
      padding: const EdgeInsets.all(largeSpacing),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Trigger Developer Logs', style: theme.textTheme.h2),
            const SizedBox(height: extraLargeSpacing),
            _LogInputRow(
              label: 'log (Finest)',
              controller: _finestController,
              buttonColor: Colors.lightGreen,
              icon: Icons.info_outline,
              onPressed: _triggerFinestLog,
            ),
            const SizedBox(height: largeSpacing),
            _LogInputRow(
              label: 'log (Finer)',
              controller: _finerController,
              buttonColor: Colors.green.shade400,
              icon: Icons.info_outline,
              onPressed: _triggerFinerLog,
            ),
            const SizedBox(height: largeSpacing),
            _LogInputRow(
              label: 'log (Fine)',
              controller: _fineController,
              buttonColor: Colors.green,
              icon: Icons.info_outline,
              onPressed: _triggerFineLog,
            ),
            const SizedBox(height: largeSpacing),
            _LogInputRow(
              label: 'log (Config)',
              controller: _configController,
              buttonColor: Colors.teal,
              icon: Icons.settings,
              onPressed: _triggerConfigLog,
            ),
            const SizedBox(height: largeSpacing),
            _LogInputRow(
              label: 'log (Info)',
              controller: _logController,
              buttonColor: Colors.blue,
              icon: Icons.info_outline,
              onPressed: _triggerInfoLog,
            ),
            const SizedBox(height: largeSpacing),
            _LogInputRow(
              label: 'log (Warning)',
              controller: _warnController,
              buttonColor: Colors.orange,
              icon: Icons.warning_amber_rounded,
              onPressed: _triggerWarningLog,
            ),
            const SizedBox(height: largeSpacing),
            _LogInputRow(
              label: 'log (Severe)',
              controller: _severeController,
              buttonColor: Colors.red,
              icon: Icons.warning_amber_rounded,
              onPressed: _triggerSevereLog,
            ),
            const SizedBox(height: largeSpacing),
            _LogInputRow(
              label: 'log (Shout)',
              controller: _shoutController,
              buttonColor: Colors.purple,
              icon: Icons.campaign,
              onPressed: _triggerShoutLog,
            ),
          ],
        ),
      ),
    );
  }
}

class _LogInputRow extends StatelessWidget {
  const _LogInputRow({
    required this.label,
    required this.controller,
    required this.buttonColor,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final TextEditingController controller;
  final Color buttonColor;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              prefixIcon: Icon(icon, color: buttonColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: buttonColor, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(width: defaultSpacing),
        SizedBox(
          height: 56,
          child: ShadButton(onPressed: onPressed, child: const Text('Log')),
        ),
      ],
    );
  }
}
