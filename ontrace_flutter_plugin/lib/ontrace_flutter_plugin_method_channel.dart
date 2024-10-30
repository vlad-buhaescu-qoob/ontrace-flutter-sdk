import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ontrace_flutter_plugin_platform_interface.dart';

class MethodChannelOntraceFlutterPlugin extends OntraceFlutterPluginPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('ontrace_flutter_plugin');

  @override
  void startAndroidActivity() {
    methodChannel.invokeMethod("startAndroidActivity");
  }

  @override
  void startIOSActivity() {
    methodChannel.invokeMethod("startIOSActivity");
  }
}
