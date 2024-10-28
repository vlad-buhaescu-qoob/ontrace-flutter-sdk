import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ontrace_flutter_plugin_platform_interface.dart';

/// An implementation of [OntraceFlutterPluginPlatform] that uses method channels.
class MethodChannelOntraceFlutterPlugin extends OntraceFlutterPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ontrace_flutter_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
