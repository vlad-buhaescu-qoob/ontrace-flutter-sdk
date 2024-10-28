import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ontrace_flutter_plugin_method_channel.dart';

abstract class OntraceFlutterPluginPlatform extends PlatformInterface {
  /// Constructs a OntraceFlutterPluginPlatform.
  OntraceFlutterPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static OntraceFlutterPluginPlatform _instance = MethodChannelOntraceFlutterPlugin();

  /// The default instance of [OntraceFlutterPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelOntraceFlutterPlugin].
  static OntraceFlutterPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [OntraceFlutterPluginPlatform] when
  /// they register themselves.
  static set instance(OntraceFlutterPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
