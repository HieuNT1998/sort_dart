#import "SortDartPlugin.h"
#if __has_include(<sort_dart/sort_dart-Swift.h>)
#import <sort_dart/sort_dart-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "sort_dart-Swift.h"
#endif

@implementation SortDartPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSortDartPlugin registerWithRegistrar:registrar];
}
@end
