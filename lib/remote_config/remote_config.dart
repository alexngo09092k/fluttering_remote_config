import 'package:fluttering/fluttering.dart';
import '../base_remote_config.dart';
import './models/remote_config_setting.dart';
import './models/remote_config_provider.dart';
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

  BaseRemoteConfig? _remoteConfig;

  AwesomeRemoteConfigSetting _setting = AwesomeRemoteConfigSetting();

  @override
  AwesomeRemoteConfigSetting get setting => _setting;

  @override
  Future<void> initial(AwesomeRemoteConfigSetting setting) async {
    _setting = setting;

    /// CHECK ENABLED
    if(!_setting.enable) return;

    /// CREATE REMOTE CONFIG INSTANCE
    if (_setting.provider == RemoteConfigProvider.huawei) {
      _remoteConfig = HuaweiRemoteConfig(
        minimumFetchInterval: _setting.minimumFetchInterval,
      );
    }

    await _remoteConfig?.initial();
  }

  @override
  Future<String?> getConfig(String key, [String? defaultConfig]) async {
    if(_remoteConfig != null && _remoteConfig!.isSupported) {
      return _remoteConfig!.getConfig(key, defaultConfig);
    }
    return defaultConfig;
  }

  @override
  Future<void> setDeaults(Map<String, dynamic> defaults) async {
    if(_remoteConfig != null && _remoteConfig!.isSupported) {
      return _remoteConfig!.setDeaults(defaults);
    }
  }
}
