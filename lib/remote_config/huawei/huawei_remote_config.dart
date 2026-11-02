// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:huawei_remote_config/huawei_remote_config.dart' as hw;
import 'package:fluttering/fluttering.dart';
import '../../base_remote_config.dart';
import '../models/remote_config_provider.dart';

class HuaweiRemoteConfig extends BaseRemoteConfig {
  @override
  RemoteConfigProvider get provider => RemoteConfigProvider.huawei;
  late Duration _minimumFetchInterval;

  HuaweiRemoteConfig({required Duration minimumFetchInterval}) {
    _minimumFetchInterval = minimumFetchInterval;
  }

  @override
  Future<String?> getConfig(String key, [String? defaultConfig]) async {
    try {
      await hw.HuaweiRemoteConfig.instance.fetchAndApply();
      String? value = await hw.HuaweiRemoteConfig.instance.getString(key);
      if (value != null && value.isNotEmpty) return value;
      return defaultConfig ?? value;
    } catch (error) {
      Debug.log('HuaweiRemoteConfig getConfig $error');
      return defaultConfig;
    }
  }

  @override
  Future<void> setDefaults(Map<String, dynamic> defaults) {
    return hw.HuaweiRemoteConfig.instance
        .applyDefaults(defaults as Map<String, Object>);
  }

  @override
  Future<bool> initial() async {
    try {
      _isSupported = await CurrentPlatform.instance.isHmsAvailable;
      Debug.log("HuaweiRemoteConfig is supported $_isSupported");
      if (_isSupported) {
        await hw.HuaweiRemoteConfig.instance.fetch(
          interval: Duration(seconds: _minimumFetchInterval.inSeconds),
        );
      }
      return true;
    } catch (error) {
      Debug.log("HuaweiRemoteConfig initial error $error");
    }
    return false;
  }

  bool _isSupported = CurrentPlatform.instance.isMobile;

  @override
  bool get isSupported => _isSupported;
}
