import './remote_config/models/remote_config_provider.dart';

abstract class BaseRemoteConfig {
  RemoteConfigProvider get provider;

  Future<String?> getConfig(String key, [String? defaultConfig]);

  Future<void> setDeaults(Map<String, dynamic> defaults);

  Future<bool> initial();

  bool get isSupported;
}
