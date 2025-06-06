import 'dart:io';

import 'ontrace_flutter_plugin_platform_interface.dart';

class OntraceFlutterPlugin {
  static final OntraceFlutterPlugin _instance =
      OntraceFlutterPlugin._internal();

  OntraceFlutterPlugin._internal();

  static OntraceFlutterPlugin get instance => _instance;

  Future<String> startIdentification(Map<String, dynamic> parameters,
      {required Function(String result) onMessage,
      required Function(String result) onComplete}) async {
    if (Platform.isAndroid) {
      return (await OntraceFlutterPluginPlatform.instance.startAndroidActivity(
        parameters,
        onMessage: onMessage,
        onComplete: onComplete,
      ));
    }
    if (Platform.isIOS) {
      return (await OntraceFlutterPluginPlatform.instance.startIOSActivity(
        parameters,
        onMessage: onMessage,
        onComplete: onComplete,
      ));
    }
    return "Platform error";
  }
}
