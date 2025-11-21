import 'package:flutter_driver/driver_extension.dart';

import 'main.dart' as app;

/// This entry point is used for AI agents to run the app with the flutter
/// driver extension enabled.
void main() {
  enableFlutterDriverExtension();
  app.main();
}
