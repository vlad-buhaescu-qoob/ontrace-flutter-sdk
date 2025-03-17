import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ontrace_flutter_plugin_platform_interface.dart';

class MethodChannelOntraceFlutterPlugin extends OntraceFlutterPluginPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('ontrace_flutter_plugin');

  @override
  Future<String> startAndroidActivity(Map<String, dynamic> parameters,
      {required Function(String result) onMessage,
      required Function(String result) onComplete}) async {
    final completer = Completer<String>();
    methodChannel.setMethodCallHandler((call) async {
      if (call.method == "receiveOnMessage") {
        onMessage("call.arguments ${call.arguments}");
      }

      if (call.method == "receiveOnComplete") {
        final result = "${call.arguments}";
        onComplete(result);
        if (!completer.isCompleted) {
          completer.complete(result);
        }
      }
    });
    await methodChannel.invokeMethod("startAndroidActivity", parameters);
    return completer.future;
  }

  @override
  Future<String> startIOSActivity(Map<String, dynamic> parameters,
      {required Function(String result) onMessage,
      required Function(String result) onComplete}) async {
    final completer = Completer<String>();
    methodChannel.setMethodCallHandler((call) async {
      if (call.method == "receiveOnMessage") {
        onMessage("call.arguments ${call.arguments}");
      }
      if (call.method == "receiveOnComplete") {
        final result = "${call.arguments}";
        onComplete(result);
        if (!completer.isCompleted) {
          completer.complete(result);
        }
      }
    });

    await methodChannel.invokeMethod("startIOSActivity", parameters);
    return completer.future;
  }
}
