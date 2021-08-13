#import "FlutterQqAdsPlugin.h"
#import "GDTSDKConfig.h"
#import "GDTSplashAd.h"

@interface FlutterQqAdsPlugin()<GDTSplashAdDelegate>

@end

@implementation FlutterQqAdsPlugin

FlutterEventSink _eventSink;
GDTSplashAd *_splashAd;
UIView *_bottomView;
BOOL *_fullScreenAd;

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
        NSString* logo=call.arguments[@"logo"];
        // 判断为空，则全屏展示
        _fullScreenAd=logo==nil||[logo isEqualToString:@""];
        // 初始化开屏广告
        _splashAd=[[GDTSplashAd alloc] initWithPlacementId:posId];
        _splashAd.delegate=self;
        // 加载全屏广告
        if(_fullScreenAd){
            [_splashAd loadFullScreenAd];
        }else{
            // 加载半屏广告
            [_splashAd loadAd];
            // 设置底部 logo
            _bottomView=nil;
            CGSize size=[[UIScreen mainScreen] bounds].size;
            CGFloat width=size.width;
            CGFloat height=112.5;// 这里按照 15% 进行logo 的展示，防止尺寸不够的问题，750*15%=112.5
            _bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,width, height)];
            _bottomView.backgroundColor=[UIColor whiteColor];
            UIImageView *logo=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"LaunchImage"]];
            logo.frame=CGRectMake(0, 0, width, height);
            logo.contentMode=UIViewContentModeCenter;
            logo.center=_bottomView.center;
            [_bottomView addSubview:logo];
        }
        result(@(YES));
        NSLog(@"显示开屏广告%@",posId);
    });
}


#pragma mark - GDTSplashAdDelegate

- (void)splashAdDidLoad:(GDTSplashAd *)splashAd {
    NSLog(@"splashAdDidLoad");
    UIWindow* mainWin=[[UIApplication sharedApplication] keyWindow];
    // 加载全屏广告
    if(_fullScreenAd){
        [splashAd showFullScreenAdInWindow:mainWin withLogoImage:_bottomView skipView:nil];
    }else{
        // 加载半屏广告
        [splashAd showAdInWindow:mainWin withBottomView:_bottomView skipView:nil];
    }
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
    _splashAd = nil;
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
