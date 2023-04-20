import 'package:flutter_test/flutter_test.dart';
import 'package:fluttering_remote_config/fluttering_remote_config_platform_interface.dart';
import 'package:fluttering_remote_config/fluttering_remote_config_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutteringRemoteConfigPlatform
    with MockPlatformInterfaceMixin
    implements FlutteringRemoteConfigPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutteringRemoteConfigPlatform initialPlatform = FlutteringRemoteConfigPlatform.instance;

  test('$MethodChannelFlutteringRemoteConfig is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutteringRemoteConfig>());
  });

  test('getPlatformVersion', () async {
    MockFlutteringRemoteConfigPlatform fakePlatform = MockFlutteringRemoteConfigPlatform();
    FlutteringRemoteConfigPlatform.instance = fakePlatform;
  });
}
