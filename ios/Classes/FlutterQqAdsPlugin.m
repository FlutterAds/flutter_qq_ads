#import "FlutterQqAdsPlugin.h"

@implementation FlutterQqAdsPlugin{
    FlutterEventSink _eventSink;
}
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* methodChannel = [FlutterMethodChannel
                                           methodChannelWithName:@"flutter_qq_ads"
                                           binaryMessenger:[registrar messenger]];
    FlutterEventChannel* eventChannel=[FlutterEventChannel eventChannelWithName:@"flutter_qq_ads_event" binaryMessenger:[registrar messenger]];
    FlutterQqAdsPlugin* instance = [[FlutterQqAdsPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:methodChannel];
    [eventChannel setStreamHandler:instance];
    
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    }else if ([@"initAd" isEqualToString:call.method]) {
        [self initAd:call result:result];
    }else if([@"showSplashAd" isEqualToString:call.method]) {
        [self showSplashAd:call result:result];
        result(@(YES));
    } else {
        result(FlutterMethodNotImplemented);
    }
}



// 初始化广告
- (void) initAd:(FlutterMethodCall*) call result:(FlutterResult) result{
    NSString* appId=call.arguments[@"appId"];
    BOOL initSuccess=[GDTSDKConfig registerAppId:appId];
    result(@(initSuccess));
    if(initSuccess){
        NSLog(@"注册成功");
    }
}

// 显示开屏广告
- (void) showSplashAd:(FlutterMethodCall*) call result:(FlutterResult) result{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString* posId=call.arguments[@"posId"];
        self.splashAd=[[GDTSplashAd alloc] initWithPlacementId:posId];
        self.splashAd.delegate=self;
        [self.splashAd loadFullScreenAd];
        result(@(YES));
        NSLog(@"显示开屏广告%@",posId);
    });
}


#pragma mark - GDTSplashAdDelegate

- (void)splashAdDidLoad:(GDTSplashAd *)splashAd {
    NSLog(@"splashAdDidLoad");
    UIWindow* mainWin=[[UIApplication sharedApplication] keyWindow];
    [splashAd showFullScreenAdInWindow:mainWin withLogoImage:nil skipView:nil];
}

- (void)splashAdSuccessPresentScreen:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdFailToPresent:(GDTSplashAd *)splashAd withError:(NSError *)error
{
    NSLog(@"%s%@",__FUNCTION__,error);
}

- (void)splashAdExposured:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdClicked:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdApplicationWillEnterBackground:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdWillClosed:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdClosed:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
    self.splashAd = nil;
}

- (void)splashAdWillPresentFullScreenModal:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdDidPresentFullScreenModal:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdWillDismissFullScreenModal:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdDidDismissFullScreenModal:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}



#pragma mark - FlutterStreamHandler
- (FlutterError * _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    _eventSink=nil;
    return nil;
}

- (FlutterError * _Nullable)onListenWithArguments:(id _Nullable)arguments eventSink:(nonnull FlutterEventSink)events {
    _eventSink=events;
    return nil;
}



@end
