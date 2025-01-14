enum RemoteConfigProvider {
  google,
  huawei,
}

extension RemoteConfigProviderExtension on RemoteConfigProvider {
  String get content => name;
}