import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:fluttering/fluttering.dart';
import '../../base_remote_config.dart';
import '../models/remote_config_provider.dart';

class GoogleRemoteConfig extends BaseRemoteConfig {
  GoogleRemoteConfig({
    required Duration fetchTimeout,
    required Duration minimumFetchInterval,
  }) {
    if(!isSupported) return;
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
  Future<bool> initial() async {
    try {
      _isSupported = CurrentPlatform.instance.isIos || await CurrentPlatform.instance.isGmsAvailable;
      Debug.log("GoogleRemoteConfig is supported $_isSupported");
      if(_isSupported) {
        await FirebaseRemoteConfig.instance.fetchAndActivate();
      }
      return true;
    }catch(error) {
      Debug.log("GoogleRemoteConfig initial error $error");
    }
    return false;
  }


  bool _isSupported = CurrentPlatform.instance.isMobile;

  @override
  bool get isSupported => _isSupported;
}
