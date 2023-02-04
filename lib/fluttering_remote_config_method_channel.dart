import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'fluttering_remote_config_platform_interface.dart';

/// An implementation of [FlutteringRemoteConfigPlatform] that uses method channels.
class MethodChannelFlutteringRemoteConfig extends FlutteringRemoteConfigPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('fluttering_remote_config');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
