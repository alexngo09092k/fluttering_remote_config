# fluttering_remote_config

**Unified Remote Config for the [Fluttering](https://pub.dev/packages/fluttering) toolkit.**

Supports **Firebase Remote Config** and **Huawei AGConnect Remote Config** with a single `getConfig` API.

---

## Features

- Entry point: `AwesomeRemoteConfig`
- Providers: Google (Firebase) + Huawei
- `getConfig(key, default)` with automatic provider fallback
- Configurable fetch interval / timeout
- Integrates with Fluttering device / platform helpers (HMS detection)

---

## Getting started

```yaml
dependencies:
  fluttering: ^3.0.0
  fluttering_remote_config: ^3.0.2
```

### Platform setup

- Firebase: add `google-services` / FlutterFire config
- Huawei: add `agconnect-services.json` and AGConnect Gradle plugin (see [huawei_remote_config](https://pub.dev/packages/huawei_remote_config))

---

## Usage

```dart
import 'package:fluttering_remote_config/fluttering_remote_config.dart';

await AwesomeRemoteConfig.instance.initial(
  AwesomeRemoteConfigSetting(
    enable: true,
    providers: [
      RemoteConfigProvider.google,
      RemoteConfigProvider.huawei,
    ],
    minimumFetchInterval: const Duration(hours: 1),
  ),
);

final value = await AwesomeRemoteConfig.instance.getConfig(
  'welcome_message',
  'Hello',
);
```

---

## Additional information

- Depends on the core **fluttering** package.
- Author: Brennan Ngo / ThemePlace
- License: MIT
