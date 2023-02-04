
import 'fluttering_remote_config_platform_interface.dart';

class FlutteringRemoteConfig {
  Future<String?> getPlatformVersion() {
    return FlutteringRemoteConfigPlatform.instance.getPlatformVersion();
  }
}
