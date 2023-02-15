import 'dart:convert';
import './remote_config_provider.dart';

class AwesomeRemoteConfigSetting {
  final bool enable;
  final List<RemoteConfigProvider> providers;
  final Duration fetchTimeout;
  final Duration minimumFetchInterval;

  AwesomeRemoteConfigSetting({
    this.enable = false,
    this.providers = const [],
    this.fetchTimeout = const Duration(milliseconds: 1000 * 60 * 60), /// 1 minutes
    this.minimumFetchInterval = const Duration(milliseconds: 1000 * 60 * 60), /// 1 minutes
  });

  AwesomeRemoteConfigSetting copyWith({
    bool? enable,
    List<RemoteConfigProvider>? providers,
    Duration? fetchTimeout,
    Duration? minimumFetchInterval,
  }) {
    return AwesomeRemoteConfigSetting(
      enable: enable ?? this.enable,
      providers: providers ?? this.providers,
      fetchTimeout: fetchTimeout ?? this.fetchTimeout,
      minimumFetchInterval: minimumFetchInterval ?? this.minimumFetchInterval,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'enable': enable,
      'providers': providers.map((e) => e.name),
      'fetchTimeout': fetchTimeout.inMilliseconds,
      'minimumFetchInterval': minimumFetchInterval.inMilliseconds,
    };
  }

  factory AwesomeRemoteConfigSetting.fromMap(Map<String, dynamic> map) {
    return AwesomeRemoteConfigSetting(
      enable: map['enable'] ?? false,
      providers: map['providers'].map((x) => RemoteConfigProvider.values.firstWhere((element) => element.name == x)).toList(),
      fetchTimeout: Duration(milliseconds: map['fetchTimeout'] ?? 0),
      minimumFetchInterval:
          Duration(milliseconds: map['minimumFetchInterval'] ?? 0),
    );
  }

  String toJson() => json.encode(toMap());

  factory AwesomeRemoteConfigSetting.fromJson(String source) => AwesomeRemoteConfigSetting.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AwesomeRemoteConfigSetting(enable: $enable, providers: $providers, fetchTimeout: $fetchTimeout, minimumFetchInterval: $minimumFetchInterval)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AwesomeRemoteConfigSetting &&
        other.enable == enable &&
        other.providers == providers &&
        other.fetchTimeout == fetchTimeout &&
        other.minimumFetchInterval == minimumFetchInterval;
  }

  @override
  int get hashCode {
    return enable.hashCode ^
        providers.hashCode ^
        fetchTimeout.hashCode ^
        minimumFetchInterval.hashCode;
  }
}
