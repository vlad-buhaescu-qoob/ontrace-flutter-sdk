import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ontrace_flutter_plugin_method_channel.dart';

abstract class OntraceFlutterPluginPlatform extends PlatformInterface {
  OntraceFlutterPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static OntraceFlutterPluginPlatform _instance =
      MethodChannelOntraceFlutterPlugin();

  static OntraceFlutterPluginPlatform get instance => _instance;

  static set instance(OntraceFlutterPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String> startAndroidActivity(Map<String, dynamic> parameters,
      {required Function(String result) onMessage,
      required Function(String result) onComplete}) async {
    throw UnimplementedError('androidActivity() has not been implemented.');
  }

  Future<String> startIOSActivity(Map<String, dynamic> parameters,
      {required Function(String result) onMessage,
      required Function(String result) onComplete}) {
    throw UnimplementedError('iOSActivity() has not been implemented.');
  }
}
