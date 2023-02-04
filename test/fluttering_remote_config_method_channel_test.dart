import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttering_remote_config/fluttering_remote_config_method_channel.dart';

void main() {
  MethodChannelFlutteringRemoteConfig platform = MethodChannelFlutteringRemoteConfig();
  const MethodChannel channel = MethodChannel('fluttering_remote_config');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
