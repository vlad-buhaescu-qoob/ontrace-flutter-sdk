import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ontrace_flutter_plugin_platform_interface.dart';

class MethodChannelOntraceFlutterPlugin extends OntraceFlutterPluginPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('ontrace_flutter_plugin');

  @override
  Future<String> startAndroidActivity() async {
    final completer = Completer<String>();
    methodChannel.setMethodCallHandler((call) async {
      if (call.method == "receiveTextFromCompose") {
        final text = call.arguments as String;
        completer.complete(text);
      }
    });
    await methodChannel.invokeMethod("startAndroidActivity");
    return completer.future;
  }

  @override
  Future<String> startIOSActivity() async {
    final completer = Completer<String>();
    methodChannel.setMethodCallHandler((call) async {
      print('call values is ${call}');
      if (call.method == "receiveTextFromSwiftUI") {
        print('call values is ${call.arguments}');
        final text = call.arguments as String;
        completer.complete(text);
      }
      
      if (call.method == "receiveMessageFromSwift") {
        print('call values is ${call.arguments}');
        final text = call.arguments as String;
        completer.complete(text);
      }
    });
    
    await methodChannel.invokeMethod("startIOSActivity");
    return completer.future;
  }
}
