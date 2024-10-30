import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ontrace_flutter_plugin/ontrace_flutter_plugin_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const MethodChannel methodChannel = MethodChannel('ontrace_flutter_plugin');
  final ontraceFlutterPlugin = MethodChannelOntraceFlutterPlugin();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(methodChannel, null);
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(methodChannel, null);
  });

  test('MethodChannel calls startAndroidActivity', () async {
    bool methodInvoked = false;

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      methodChannel,
      (MethodCall methodCall) async {
        if (methodCall.method == 'startAndroidActivity') {
          methodInvoked = true;
        }
        return null;
      },
    );

    ontraceFlutterPlugin.startAndroidActivity();
    await Future.delayed(Duration.zero);
    expect(methodInvoked, isTrue);
  });

  test('MethodChannel calls startIOSActivity', () async {
    bool methodInvoked = false;

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      methodChannel,
      (MethodCall methodCall) async {
        if (methodCall.method == 'startIOSActivity') {
          methodInvoked = true;
        }
        return null;
      },
    );

    ontraceFlutterPlugin.startIOSActivity();
    await Future.delayed(Duration.zero);
    expect(methodInvoked, isTrue);
  });
}
