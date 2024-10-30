import 'dart:io';

import 'package:flutter/widgets.dart';
import 'ontrace_flutter_plugin_platform_interface.dart';

class OntraceFlutterPlugin extends StatefulWidget {
  const OntraceFlutterPlugin({super.key});

  @override
  State<OntraceFlutterPlugin> createState() => _OntraceFlutterPluginState();
}

class _OntraceFlutterPluginState extends State<OntraceFlutterPlugin> {
  @override
  void initState() {
    if (Platform.isAndroid) {
      return OntraceFlutterPluginPlatform.instance.startAndroidActivity();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
