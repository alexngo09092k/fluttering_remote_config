import 'package:fluttering/fluttering.dart';
import '../base_remote_config.dart';
import './models/remote_config_setting.dart';
import './models/remote_config_provider.dart';
import './google/google_remote_config.dart';
import './huawei/huawei_remote_config.dart';

abstract class IAwesomeRemoteConfig extends Provider with ProviderDelegate {
  AwesomeRemoteConfigSetting get setting;

  void initial(AwesomeRemoteConfigSetting setting);

  Future<String?> getConfig(String key, [String? defaultConfig]);

  Future<void> setDeaults(Map<String, dynamic> defaults);
}

class AwesomeRemoteConfig extends IAwesomeRemoteConfig {
  static final IAwesomeRemoteConfig _instance = AwesomeRemoteConfig._internal();
  static IAwesomeRemoteConfig get instance => _instance;

  factory AwesomeRemoteConfig() => _instance as AwesomeRemoteConfig;

  AwesomeRemoteConfig._internal();

  final Map<RemoteConfigProvider, BaseRemoteConfig> _remoteConfigs = {};

  AwesomeRemoteConfigSetting _setting = AwesomeRemoteConfigSetting();

  @override
  AwesomeRemoteConfigSetting get setting => _setting;

  @override
  Future<void> initial(AwesomeRemoteConfigSetting setting) async {
    _setting = setting;

    /// CHECK ENABLED
    if(!_setting.enable) return;

    /// CREATE REMOTE CONFIG INSTANCE
    for (var provider in _setting.providers) {
      BaseRemoteConfig? remoteConfig;
      if(!_remoteConfigs.containsKey(provider)) {
        if (provider == RemoteConfigProvider.google) {
          remoteConfig = GoogleRemoteConfig(
            minimumFetchInterval: _setting.minimumFetchInterval,
            fetchTimeout: _setting.fetchTimeout,
          );
        } else if (provider == RemoteConfigProvider.huawei) {
          remoteConfig = HuaweiRemoteConfig(
            minimumFetchInterval: _setting.minimumFetchInterval,
          );
        }
      }
      if(remoteConfig != null) {
        await remoteConfig.initial();
        _remoteConfigs[provider] = remoteConfig;
      }
    }
  }

  @override
  Future<String?> getConfig(String key, [String? defaultConfig, RemoteConfigProvider? provider]) async {
    if(provider != null) {
      if(_remoteConfigs[provider] != null && _remoteConfigs[provider]!.isSupported) {
        return _remoteConfigs[provider]!.getConfig(key, defaultConfig);
      }
      return defaultConfig;
    }else {
      for (var remoteConfig in _remoteConfigs.values) {
        if(remoteConfig.isSupported) {
          final result = await remoteConfig.getConfig(key, null);
          if(result != null) {
            return result;
          }
        }
      }
      return defaultConfig;
    }
  }

  @override
  Future<void> setDeaults(Map<String, dynamic> defaults, [RemoteConfigProvider? provider]) async {
    if(provider != null) {
      if(_remoteConfigs[provider] != null && _remoteConfigs[provider]!.isSupported) {
        _remoteConfigs[provider]!.setDeaults(defaults);
      }
    }else {
      _remoteConfigs.forEach((key, remoteConfig) {
        if(remoteConfig.isSupported) {
          remoteConfig.setDeaults(defaults);
        }
      });
    }
  }
}
