import 'dart:async';

import 'package:flutter/material.dart' hide Checkbox, TextFormField;
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../shared/ui/theme.dart';
import 'http_client.dart';
import 'http_server.dart';

class NetworkScreen extends StatefulWidget {
  const NetworkScreen({super.key});

  @override
  State<NetworkScreen> createState() => _NetworkScreenState();
}

class _NetworkScreenState extends State<NetworkScreen> {
  final _httpClient = HttpClient();

  final Future<HttpServer> _server = HttpServer.create();

  @override
  Widget build(BuildContext context) {
    // Initialize the global HTTP server.
    unawaited(_server);
    return SingleChildScrollView(
      child: RequestTable(
        httpClient: _httpClient,
        networkNotifier: _networkNotifier,
      ),
    );
  }

  void _networkNotifier(String text) {
    final toast = ShadToast(
      alignment: Alignment.topCenter,
      description: Text(text),
      backgroundColor: ShadTheme.of(context).colorScheme.accent,
    );
    ShadToaster.of(context).show(toast);
  }
}

class _RequestSettings {
  _RequestSettings({
    required this.type,
    required this.action,
    this.requestHasBody = false,
    this.requestCanHaveBody = true,
  });

  final _RequestType type;
  final void Function({
    required Logger networkNotifier,
    required bool requestHasBody,
    required int responseCode,
    required bool responseHasBody,
    bool shouldComplete,
  })
  action;

  /// `null` means disabled.
  bool? requestHasBody;
  bool requestCanHaveBody;
  int responseCode = 200;
  bool responseHasBody = true;
  bool shouldComplete = true;
  bool shouldRepeat = false;
}

enum _RequestType {
  httpGet('dart:io GET'),
  httpPost('dart:io POST'),
  httpPut('dart:io PUT'),
  httpDelete('dart:io DELETE'),
  packageHttpGet('package:http GET'),
  packageHttpPost('package:http POST'),
  packageHttpPostStreamed('package:http POST (streamed)'),
  packageHttpDelete('package:http DELETE'),
  dioGet('Dio GET'),
  dioPost('Dio POST');
  // TODO: WebSocket
  // TODO: cronet_http - https://pub.dev/packages/cronet_http
  // TODO: ok_http - https://pub.dev/packages/ok_http

  const _RequestType(this.text);

  final String text;
}

typedef Logger = void Function(String);

class RequestTable extends StatefulWidget {
  const RequestTable({
    required HttpClient httpClient,
    required Logger networkNotifier,
    super.key,
  }) : _httpClient = httpClient,
       _networkNotifier = networkNotifier;

  final HttpClient _httpClient;
  final Logger _networkNotifier;

  @override
  State<RequestTable> createState() => _RequestTableState();
}

class _RequestTableState extends State<RequestTable> {
  final _repeatingTimers = <_RequestSettings, Timer>{};

  @override
  void dispose() {
    for (final timer in _repeatingTimers.values) {
      timer.cancel();
    }
    super.dispose();
  }

  // ... [Keep your settingsList initialization here exactly as it was] ...
  late List<_RequestSettings> settingsList = [
    _RequestSettings(
      type: _RequestType.httpGet,
      action: widget._httpClient.get,
      requestHasBody: null,
      requestCanHaveBody: false,
    ),
    _RequestSettings(
      type: _RequestType.httpPost,
      action: widget._httpClient.post,
    ),
    _RequestSettings(
      type: _RequestType.httpPut,
      action: widget._httpClient.put,
    ),
    _RequestSettings(
      type: _RequestType.httpDelete,
      action: widget._httpClient.delete,
      requestHasBody: null,
      requestCanHaveBody: false,
    ),
    _RequestSettings(
      type: _RequestType.packageHttpGet,
      action: widget._httpClient.packageHttpGet,
    ),
    _RequestSettings(
      type: _RequestType.packageHttpPost,
      action: widget._httpClient.packageHttpPost,
    ),
    _RequestSettings(
      type: _RequestType.packageHttpPostStreamed,
      action: widget._httpClient.packageHttpPostStreamed,
      requestHasBody: null,
    ),
    _RequestSettings(
      type: _RequestType.packageHttpDelete,
      action: widget._httpClient.packageHttpDelete,
    ),
    _RequestSettings(
      type: _RequestType.dioGet,
      action: widget._httpClient.dioGet,
    ),
    _RequestSettings(
      type: _RequestType.dioPost,
      action: widget._httpClient.dioPost,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          for (var i = 0; i < settingsList.length; i++) ...[
            () {
              final settings = settingsList[i];
              return ShadCard(
                child: Padding(
                  padding: const EdgeInsets.all(densePadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              settings.type.text,
                              style: ShadTheme.of(context).textTheme.h4,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Code: ',
                                style: ShadTheme.of(context).textTheme.p,
                              ),
                              SizedBox(
                                width: 60,
                                child: ShadInput(
                                  initialValue: '200',
                                  keyboardType: TextInputType.number,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: defaultPadding,
                                    vertical: densePadding,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      settings.responseCode =
                                          int.tryParse(value) ?? 200;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: denseSpacing),
                      const Divider(),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio: 4.5,
                        children: [
                          _buildCheckboxRow(
                            label: 'Request Body',
                            value:
                                settings.requestHasBody ??
                                settings.requestCanHaveBody,
                            enabled: settings.requestHasBody != null,
                            onChanged: (val) =>
                                setState(() => settings.requestHasBody = val),
                          ),
                          _buildCheckboxRow(
                            label: 'Response Body',
                            value: settings.responseHasBody,
                            onChanged: (val) =>
                                setState(() => settings.responseHasBody = val),
                          ),
                          _buildCheckboxRow(
                            label: 'Completes',
                            value: settings.shouldComplete,
                            onChanged: (val) =>
                                setState(() => settings.shouldComplete = val),
                          ),
                          _buildCheckboxRow(
                            label: 'Repeats',
                            value: settings.shouldRepeat,
                            onChanged: (val) =>
                                setState(() => settings.shouldRepeat = val),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ShadButton(
                          onPressed: () => _handleAction(settings),
                          child: Text(
                            settings.shouldRepeat
                                ? (_repeatingTimers.containsKey(settings)
                                      ? 'Stop'
                                      : 'Start Loop')
                                : 'Send Request',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }(),
            if (i < settingsList.length - 1)
              const SizedBox(height: largeSpacing),
          ],
        ],
      ),
    );
  }

  Widget _buildCheckboxRow({
    required String label,
    required bool value,
    required Function(bool) onChanged,
    bool enabled = true,
  }) {
    return Row(
      children: [
        ShadCheckbox(value: value, onChanged: enabled ? onChanged : null),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: enabled ? null : Theme.of(context).disabledColor,
              fontSize: 12,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  void _handleAction(_RequestSettings settings) {
    if (settings.shouldRepeat) {
      if (_repeatingTimers.containsKey(settings)) {
        // Stop the timer.
        _repeatingTimers[settings]!.cancel();
        setState(() {
          _repeatingTimers.remove(settings);
        });
      } else {
        // Start the timer.
        final timer = Timer.periodic(
          const Duration(seconds: 1),
          (timer) => _runAction(settings),
        );
        setState(() {
          _repeatingTimers[settings] = timer;
        });
      }
    } else {
      // Just run once.
      _runAction(settings);
    }
  }

  void _runAction(_RequestSettings settings) {
    settings.action(
      networkNotifier: widget._networkNotifier,
      requestHasBody: settings.requestHasBody ?? false,
      responseCode: settings.responseCode,
      responseHasBody: settings.responseHasBody,
      shouldComplete: settings.shouldComplete,
    );
  }
}
