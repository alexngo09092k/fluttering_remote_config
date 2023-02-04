import 'package:flutter/foundation.dart';

enum RemoteConfigProvider {
  google,
  huawei,
}

extension RemoteConfigProviderExtension on RemoteConfigProvider {
  String get content => describeEnum(this);
}