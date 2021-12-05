//
//  FAQNativeViewFactory.m
//  flutter_qq_ads
//
//  Created by zero on 2021/8/31.
//

#import "FAQNativeViewFactory.h"
// 原生平台 View 工厂
@implementation FAQNativeViewFactory

- (instancetype)initWithViewName:(NSString *)viewName withMessenger:(NSObject<FlutterBinaryMessenger> *)messenger withPlugin:(FlutterQqAdsPlugin *)plugin{
    self = [super init];
    if (self) {
        self.viewName = viewName;
        self.messenger = messenger;
        self.plugin = plugin;
    }
    return self;
}

- (NSObject<FlutterMessageCodec>*)createArgsCodec {
    return [FlutterStandardMessageCodec sharedInstance];
}

- (NSObject<FlutterPlatformView>*)createWithFrame:(CGRect)frame
                                   viewIdentifier:(int64_t)viewId
                                        arguments:(id _Nullable)args {
    if(self.viewName==kFAQAdBannerViewId){
        return [[FAQAdBannerView alloc] initWithFrame:frame
                                       viewIdentifier:viewId
                                            arguments:args
                                      binaryMessenger:self.messenger
                                               plugin:self.plugin];
        
    }else{
        return [[FAQAdFeedView alloc] initWithFrame:frame
                                     viewIdentifier:viewId
                                          arguments:args
                                    binaryMessenger:self.messenger
                                             plugin:self.plugin];
    }
}
@end
