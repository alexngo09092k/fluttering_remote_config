import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'fluttering_remote_config_method_channel.dart';

abstract class FlutteringRemoteConfigPlatform extends PlatformInterface {
  /// Constructs a FlutteringRemoteConfigPlatform.
  FlutteringRemoteConfigPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutteringRemoteConfigPlatform _instance = MethodChannelFlutteringRemoteConfig();

  /// The default instance of [FlutteringRemoteConfigPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutteringRemoteConfig].
  static FlutteringRemoteConfigPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutteringRemoteConfigPlatform] when
  /// they register themselves.
  static set instance(FlutteringRemoteConfigPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
