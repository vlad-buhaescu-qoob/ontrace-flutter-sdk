import 'dart:io';

import 'ontrace_flutter_plugin_platform_interface.dart';

class OntraceFlutterPlugin {
  Future<String> startIdentification() async {
    if (Platform.isAndroid) {
      return (await OntraceFlutterPluginPlatform.instance.startAndroidActivity());
    }
    if (Platform.isIOS) {
     return (await OntraceFlutterPluginPlatform.instance.startIOSActivity());
    }
    return "Platform error";
  }
}
