//
//  FAQNativeViewFactory.m
//  flutter_qq_ads
//
//  Created by zero on 2021/8/31.
//

#import "FAQNativeViewFactory.h"
// 原生平台 View 工厂
@implementation FAQNativeViewFactory

- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger withPlugin:(FlutterQqAdsPlugin *)plugin{
    self = [super init];
    if (self) {
        self.messenger = messenger;
        self.plugin=plugin;
    }
    return self;
}

- (NSObject<FlutterMessageCodec>*)createArgsCodec {
    return [FlutterStandardMessageCodec sharedInstance];
}

- (NSObject<FlutterPlatformView>*)createWithFrame:(CGRect)frame
                                   viewIdentifier:(int64_t)viewId
                                        arguments:(id _Nullable)args {
    return [[FAQAdBannerView alloc] initWithFrame:frame
                                viewIdentifier:viewId
                                     arguments:args
                               binaryMessenger:self.messenger
                                        plugin:self.plugin];
}
@end
