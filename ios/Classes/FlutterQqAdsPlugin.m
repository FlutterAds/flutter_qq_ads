#import "FlutterQqAdsPlugin.h"
#import "GDTSDKConfig.h"
#import "FAQNativeViewFactory.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>


@implementation FlutterQqAdsPlugin

// AdBannerView
NSString *const kFAQAdBannerViewId=@"flutter_qq_ads_banner";
// AdFeedView
NSString *const kFAQAdFeedViewId=@"flutter_qq_ads_feed";

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    // 方法通道
    FlutterMethodChannel* methodChannel = [FlutterMethodChannel
                                           methodChannelWithName:@"flutter_qq_ads"
                                           binaryMessenger:[registrar messenger]];
    // 事件通道
    FlutterEventChannel* eventChannel=[FlutterEventChannel eventChannelWithName:@"flutter_qq_ads_event" binaryMessenger:[registrar messenger]];
    // 注册方法和事件通道
    FlutterQqAdsPlugin* instance = [[FlutterQqAdsPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:methodChannel];
    [eventChannel setStreamHandler:instance];
    // 注册平台View 工厂
    FAQNativeViewFactory *bannerFactory=[[FAQNativeViewFactory alloc] initWithViewName:kFAQAdBannerViewId withMessenger:registrar.messenger withPlugin:instance];
    FAQNativeViewFactory *feedFactory=[[FAQNativeViewFactory alloc] initWithViewName:kFAQAdFeedViewId withMessenger:registrar.messenger withPlugin:instance];
    // 注册 Banner View
    [registrar registerViewFactory:bannerFactory withId:kFAQAdBannerViewId];
    // 注册 Feed View
    [registrar registerViewFactory:feedFactory withId:kFAQAdFeedViewId];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString *methodStr=call.method;
    if ([@"getPlatformVersion" isEqualToString:methodStr]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    }else if ([@"requestIDFA" isEqualToString:methodStr]) {
        [self requestIDFA:call result:result];
    }else if ([@"initAd" isEqualToString:methodStr]) {
        [self initAd:call result:result];
    }else if ([@"setPersonalizedState" isEqualToString:methodStr]) {
        [self setPersonalizedState:call result:result];
    }else if([@"showSplashAd" isEqualToString:methodStr]) {
        [self showSplashAd:call result:result];
    }else if ([@"showInterstitialAd" isEqualToString:methodStr]){
        [self showInterstitialAd:call result:result];
    }else if ([@"showRewardVideoAd" isEqualToString:methodStr]){
        [self showRewardVideoAd:call result:result];
    }else if ([@"loadFeedAd" isEqualToString:methodStr]){
        [self loadFeedAd:call result:result];
    }else if ([@"clearFeedAd" isEqualToString:methodStr]){
        [self clearFeedAd:call result:result];
    }else {
        result(FlutterMethodNotImplemented);
    }
}
// 请求 IDFA
- (void) requestIDFA:(FlutterMethodCall*) call result:(FlutterResult) result{
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            BOOL requestResult=status == ATTrackingManagerAuthorizationStatusAuthorized;
            NSLog(@"requestIDFA:%@",requestResult?@"YES":@"NO");
            result(@(requestResult));
        }];
    } else {
        result(@(YES));
    }
}

// 初始化广告
- (void) initAd:(FlutterMethodCall*) call result:(FlutterResult) result{
    NSString* appId=call.arguments[@"appId"];
    BOOL initSuccess=[GDTSDKConfig initWithAppId:appId];
    [GDTSDKConfig startWithCompletionHandler:^(BOOL success, NSError *error) {
        result(@(success));
        if (success) {
            result(@(YES));
        } else {
            result(@(NO));
            NSLog(@"FlutterQqAdsPlugin initAd error:%@",error.description);
        }
    }];
    
}

// 设置广告个性化
- (void) setPersonalizedState:(FlutterMethodCall*) call result:(FlutterResult) result{
    int state = [call.arguments[@"state"] intValue];
    [GDTSDKConfig setPersonalizedState:state];
    result(@(YES));
}

// 显示开屏广告
- (void) showSplashAd:(FlutterMethodCall*) call result:(FlutterResult) result{
    self.sad=[[FAQSplashPage alloc] init];
    [self.sad showAd:call eventSink:self.eventSink];
    result(@(YES));
}

// 显示插屏广告
- (void) showInterstitialAd:(FlutterMethodCall*) call result:(FlutterResult) result{
    self.iad=[[FAQInterstitialPage alloc] init];
    [self.iad showAd:call eventSink:self.eventSink];
    result(@(YES));
}

// 显示激励视频广告
- (void) showRewardVideoAd:(FlutterMethodCall*) call result:(FlutterResult) result{
    self.rvad=[[FAQRewardVideoPage alloc] init];
    [self.rvad showAd:call eventSink:self.eventSink];
    result(@(YES));
}

// 加载信息流广告
- (void) loadFeedAd:(FlutterMethodCall*) call result:(FlutterResult) result{
    self.fad=[[FAQFeedAdLoad alloc] init];
    [self.fad loadFeedAdList:call result:result eventSink:self.eventSink];
}

// 清除信息流广告
- (void) clearFeedAd:(FlutterMethodCall*) call result:(FlutterResult) result{
    NSArray *list= call.arguments[@"list"];
    for (NSNumber *ad in list) {
        [FAQFeedAdManager.share removeAd:ad];
    }
    result(@(YES));
}


#pragma mark - FlutterStreamHandler
- (FlutterError * _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    self.eventSink=nil;
    return nil;
}

- (FlutterError * _Nullable)onListenWithArguments:(id _Nullable)arguments eventSink:(nonnull FlutterEventSink)events {
    self.eventSink=events;
    return nil;
}

// 添加事件
-(void) addEvent:(NSObject *) event{
    if(self.eventSink!=nil){
        self.eventSink(event);
    }
}

@end
