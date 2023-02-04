import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import '../base_remote_config.dart';
import './models/remote_config_setting.dart';
import './models/remote_config_provider.dart';
import './google/google_remote_config.dart';
import './huawei/huawei_remote_config.dart';

abstract class IAwesomeRemoteConfig extends Provider with ProviderDelegate {
  AwesomeRemoteConfigSetting get setting;

  RemoteConfigProvider get provider => setting.provider;

  void initial(AwesomeRemoteConfigSetting setting);

  Future<String?> getConfig(String key, [String? defaultConfig]);

  Future<void> setDeaults(Map<String, dynamic> defaults);
}

class AwesomeRemoteConfig extends IAwesomeRemoteConfig {
  static final IAwesomeRemoteConfig _instance = AwesomeRemoteConfig._internal();
  static IAwesomeRemoteConfig get instance => _instance;

  factory AwesomeRemoteConfig() => _instance as AwesomeRemoteConfig;

  AwesomeRemoteConfig._internal();

  late BaseRemoteConfig _remoteConfig;

  AwesomeRemoteConfigSetting _setting = AwesomeRemoteConfigSetting();

  @override
  AwesomeRemoteConfigSetting get setting => _setting;

  @override
  Future<bool> initial(AwesomeRemoteConfigSetting setting) async {
    _setting = setting;

    if (_setting.provider == RemoteConfigProvider.google) {
      _remoteConfig = GoogleRemoteConfig(
        minimumFetchInterval: _setting.minimumFetchInterval,
        fetchTimeout: _setting.fetchTimeout,
      );
    } else if (_setting.provider == RemoteConfigProvider.huawei) {
      _remoteConfig = HuaweiRemoteConfig(
        minimumFetchInterval: _setting.minimumFetchInterval,
      );
    } else {
      throw ErrorDescription(
          'No support InAppPuchase ${_setting.provider.name}');
    }
    return _remoteConfig.initial();
  }

  @override
  Future<String?> getConfig(String key, [String? defaultConfig]) {
    return _remoteConfig.getConfig(key, defaultConfig);
  }

  @override
  Future<void> setDeaults(Map<String, dynamic> defaults) {
    return _remoteConfig.setDeaults(defaults);
  }
}
