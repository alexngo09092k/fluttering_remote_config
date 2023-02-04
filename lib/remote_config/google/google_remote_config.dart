import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:fluttering/fluttering.dart';
import '../../base_remote_config.dart';
import '../models/remote_config_provider.dart';

class GoogleRemoteConfig extends BaseRemoteConfig {
  GoogleRemoteConfig({
    required Duration fetchTimeout,
    required Duration minimumFetchInterval,
  }) {
    FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: fetchTimeout,
      minimumFetchInterval: minimumFetchInterval,
    ));
  }

  @override
  RemoteConfigProvider get provider => RemoteConfigProvider.google;

  @override
  Future<String?> getConfig(String key, [String? defaultConfig]) async {
    try {
      String value = FirebaseRemoteConfig.instance.getString(key);
      if (value.isNotEmpty) return value;
      return defaultConfig ?? value;
    } catch (error) {
      Debug.log('GoogleRemoteConfig getConfig $error');
      return defaultConfig;
    }
  }

  @override
  Future<void> setDeaults(Map<String, dynamic> defaults) {
    return FirebaseRemoteConfig.instance.setDefaults(defaults);
  }

  @override
  Future<bool> initial() {
    return FirebaseRemoteConfig.instance.fetchAndActivate();
  }
}
