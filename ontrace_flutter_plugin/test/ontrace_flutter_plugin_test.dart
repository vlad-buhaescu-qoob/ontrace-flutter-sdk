import 'package:flutter_test/flutter_test.dart';
import 'package:ontrace_flutter_plugin/ontrace_flutter_plugin_platform_interface.dart';
import 'package:ontrace_flutter_plugin/ontrace_flutter_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockOntraceFlutterPluginPlatform
    with MockPlatformInterfaceMixin
    implements OntraceFlutterPluginPlatform {
  @override
  void startAndroidActivity() {}
}

void main() {
  final OntraceFlutterPluginPlatform initialPlatform =
      OntraceFlutterPluginPlatform.instance;

  test('$MethodChannelOntraceFlutterPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelOntraceFlutterPlugin>());
  });
}
