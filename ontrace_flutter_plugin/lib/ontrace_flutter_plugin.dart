
import 'ontrace_flutter_plugin_platform_interface.dart';

class OntraceFlutterPlugin {
  Future<String?> getPlatformVersion() {
    return OntraceFlutterPluginPlatform.instance.getPlatformVersion();
  }
}
