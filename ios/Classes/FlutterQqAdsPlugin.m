#import "FlutterQqAdsPlugin.h"
#import "GDTSDKConfig.h"
#import "GDTSplashAd.h"
#import "AdEvent.h"
#import "AdErrorEvent.h"
#import "AdEventAction.h"

@interface FlutterQqAdsPlugin()<GDTSplashAdDelegate>
@property (strong, nonatomic) FlutterEventSink eventSink;
@property (strong, nonatomic) GDTSplashAd *splashAd;
@property (retain, nonatomic) UIView *bottomView;
@property (nonatomic, assign) BOOL fullScreenAd;
@property (weak,nonatomic) NSString *posId;
@end

@implementation FlutterQqAdsPlugin


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
        self.posId=call.arguments[@"posId"];
        NSString* logo=call.arguments[@"logo"];
        // logo 判断为空，则全屏展示
        self.fullScreenAd=[logo isKindOfClass:[NSNull class]]||[logo length]==0;
        // 初始化开屏广告
        self.splashAd=[[GDTSplashAd alloc] initWithPlacementId:self.posId];
        self.splashAd.delegate=self;
        // 加载全屏广告
        if(self.fullScreenAd){
            [self.splashAd loadFullScreenAd];
        }else{
            // 加载半屏广告
            [self.splashAd loadAd];
            // 设置底部 logo
            self.bottomView=nil;
            CGSize size=[[UIScreen mainScreen] bounds].size;
            CGFloat width=size.width;
            CGFloat height=112.5;// 这里按照 15% 进行logo 的展示，防止尺寸不够的问题，750*15%=112.5
            self.bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,width, height)];
            self.bottomView.backgroundColor=[UIColor whiteColor];
            UIImageView *logoView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:logo]];
            logoView.frame=CGRectMake(0, 0, width, height);
            logoView.contentMode=UIViewContentModeCenter;
            logoView.center=self.bottomView.center;
            [self.bottomView addSubview:logoView];
        }
        result(@(YES));
        NSLog(@"显示开屏广告%@",self.posId);
    });
}


#pragma mark - GDTSplashAdDelegate

- (void)splashAdDidLoad:(GDTSplashAd *)splashAd {
    NSLog(@"splashAdDidLoad");
    UIWindow* mainWin=[[UIApplication sharedApplication] keyWindow];
    // 加载全屏广告
    if(self.fullScreenAd){
        [self.splashAd showFullScreenAdInWindow:mainWin withLogoImage:nil skipView:nil];
    }else{
        // 加载半屏广告
        [self.splashAd showAdInWindow:mainWin withBottomView:_bottomView skipView:nil];
    }
    // 添加广告事件
    AdEvent *event=[[AdEvent alloc] initWithAdId:self.posId andAction:onAdLoaded];
    [self addAdEvent:event];
}

- (void)splashAdSuccessPresentScreen:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
    // 添加广告事件
    AdEvent *event=[[AdEvent alloc] initWithAdId:self.posId andAction:onAdPresent];
    [self addAdEvent:event];
}

- (void)splashAdFailToPresent:(GDTSplashAd *)splashAd withError:(NSError *)error
{
    NSLog(@"%s%@",__FUNCTION__,error);
    // 添加广告错误事件
    AdErrorEvent *event=[[AdErrorEvent alloc] initWithAdId:self.posId errCode:[NSNumber numberWithInteger:error.code] errMsg:error.localizedDescription];
    [self addAdEvent:event];
}

- (void)splashAdExposured:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
    // 添加广告事件
    AdEvent *event=[[AdEvent alloc] initWithAdId:self.posId andAction:onAdExposure];
    [self addAdEvent:event];
}

- (void)splashAdClicked:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
    // 添加广告事件
    AdEvent *event=[[AdEvent alloc] initWithAdId:self.posId andAction:onAdClicked];
    [self addAdEvent:event];
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
    // 添加广告事件
    AdEvent *event=[[AdEvent alloc] initWithAdId:self.posId andAction:onAdClosed];
    [self addAdEvent:event];
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

// 添加广告事件
-(void) addAdEvent:(AdEvent *) event{
    if(event!=nil){
        [self addEvent:[event toMap]];
    }
}

@end
