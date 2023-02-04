#import "FlutteringRemoteConfigPlugin.h"
#if __has_include(<fluttering_remote_config/fluttering_remote_config-Swift.h>)
#import <fluttering_remote_config/fluttering_remote_config-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "fluttering_remote_config-Swift.h"
#endif

@implementation FlutteringRemoteConfigPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutteringRemoteConfigPlugin registerWithRegistrar:registrar];
}
@end
