//
//  FAQInterstitialPage.m
//  flutter_qq_ads
//
//  Created by zero on 2021/8/18.
//

#import "FAQInterstitialPage.h"
#import "GDTUnifiedInterstitialAd.h"

// 插屏广告
@interface FAQInterstitialPage()<GDTUnifiedInterstitialAdDelegate>
@property (nonatomic, strong) GDTUnifiedInterstitialAd *iad;
// 全屏视频形式展示
@property BOOL showFullScreenVideo;
// 激励视频形式展示
@property BOOL showRewardVideo;
// 服务端验证的自定义信息
@property (copy,nonatomic) NSString *customData;
// 服务端验证的用户信息
@property (copy,nonatomic) NSString *userId;
@end

@implementation FAQInterstitialPage

- (void)dealloc
{
    NSLog(@"InterstitialPage dealloc");
}
// 加载广告
- (void)loadAd:(FlutterMethodCall *)call{
    NSLog(@"加载广告:%@",self.posId);
    
    
    self.iad=[[GDTUnifiedInterstitialAd alloc] initWithPlacementId:self.posId];
    self.iad.delegate=self;
    [self setOption:call];
    // 插屏全屏视频或插屏激励视频加载方式
    if (self.showFullScreenVideo||self.showRewardVideo) {
        [self.iad loadFullScreenAd];
    } else {
        [self.iad loadAd];
    }
    
}
// 配置项
- (void) setOption:(FlutterMethodCall *) call{
    self.showFullScreenVideo = [call.arguments[@"showFullScreenVideo"] boolValue];
    self.showRewardVideo= [call.arguments[@"showRewardVideo"] boolValue];
    BOOL autoPlayMuted = [call.arguments[@"autoPlayMuted"] boolValue];
    BOOL autoPlayOnWifi = [call.arguments[@"autoPlayOnWifi"] boolValue];
    BOOL detailPageMuted = [call.arguments[@"detailPageMuted"] boolValue];
    self.iad.videoAutoPlayOnWWAN=autoPlayOnWifi;
    self.iad.videoMuted=autoPlayMuted;
    self.iad.detailPageVideoMuted=detailPageMuted;
    // 激励视频配置项
    if (self.showRewardVideo) {
        self.customData = call.arguments[@"customData"] ;
        self.userId = call.arguments[@"userId"];
        //如果设置了服务端验证，可以设置serverSideVerificationOptions属性
        GDTServerSideVerificationOptions *ssv = [[GDTServerSideVerificationOptions alloc] init];
        ssv.userIdentifier = self.userId;
        ssv.customRewardString = self.customData;
        self.iad.serverSideVerificationOptions = ssv;
    }
}

#pragma mark - GDTUnifiedInterstitialAdDelegate

/**
 *  插屏2.0广告预加载成功回调
 *  当接收服务器返回的广告数据成功后调用该函数
 */
- (void)unifiedInterstitialSuccessToLoadAd:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self sendEventAction:onAdLoaded];
}

/**
 *  插屏2.0广告预加载失败回调
 *  当接收服务器返回的广告数据失败后调用该函数
 */
- (void)unifiedInterstitialFailToLoadAd:(GDTUnifiedInterstitialAd *)unifiedInterstitial error:(NSError *)error
{
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"interstitial fail to load, Error : %@",error);
    // 发送广告错误事件
    [self sendErrorEvent:error.code withErrMsg:error.localizedDescription];
}


- (void)unifiedInterstitialDidDownloadVideo:(GDTUnifiedInterstitialAd *)unifiedInterstitial {
    NSLog(@"%s",__FUNCTION__);
}

- (void)unifiedInterstitialRenderSuccess:(GDTUnifiedInterstitialAd *)unifiedInterstitial {
    NSLog(@"%s",__FUNCTION__);
    UIViewController* controller = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (self.showFullScreenVideo||self.showRewardVideo) {
        [self.iad presentFullScreenAdFromRootViewController:controller];
    }else{
        [self.iad presentAdFromRootViewController:controller];
    }
    
}

- (void)unifiedInterstitialRenderFail:(GDTUnifiedInterstitialAd *)unifiedInterstitial error:(NSError *)error {
    NSLog(@"%s",__FUNCTION__);
    // 添加广告错误事件
    FAQAdErrorEvent *event=[[FAQAdErrorEvent alloc] initWithAdId:self.posId errCode:[NSNumber numberWithInteger:error.code] errMsg:error.localizedDescription];
    [self sendEvent:event];
}

/**
 *  插屏2.0广告将要展示回调
 *  插屏2.0广告即将展示回调该函数
 */
- (void)unifiedInterstitialWillPresentScreen:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)unifiedInterstitialFailToPresent:(GDTUnifiedInterstitialAd *)unifiedInterstitial error:(NSError *)error {
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  插屏2.0广告视图展示成功回调
 *  插屏2.0广告展示成功回调该函数
 */
- (void)unifiedInterstitialDidPresentScreen:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self sendEventAction:onAdPresent];
}

/**
 *  插屏2.0广告展示结束回调
 *  插屏2.0广告展示结束回调该函数
 */
- (void)unifiedInterstitialDidDismissScreen:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self sendEventAction:onAdClosed];
}

/**
 *  当点击下载应用时会调用系统程序打开
 */
- (void)unifiedInterstitialWillLeaveApplication:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  插屏2.0广告曝光回调
 */
- (void)unifiedInterstitialWillExposure:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self sendEventAction:onAdExposure];
}

/**
 *  插屏2.0广告点击回调
 */
- (void)unifiedInterstitialClicked:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self sendEventAction:onAdClicked];
}

/**
 *  点击插屏2.0广告以后即将弹出全屏广告页
 */
- (void)unifiedInterstitialAdWillPresentFullScreenModal:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  点击插屏2.0广告以后弹出全屏广告页
 */
- (void)unifiedInterstitialAdDidPresentFullScreenModal:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  全屏广告页将要关闭
 */
- (void)unifiedInterstitialAdWillDismissFullScreenModal:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  全屏广告页被关闭
 */
- (void)unifiedInterstitialAdDidDismissFullScreenModal:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)unifiedInterstitialAdDidRewardEffective:(GDTUnifiedInterstitialAd *)unifiedInterstitial info:(NSDictionary *)info {
    NSString *transId=[info objectForKey:@"GDT_TRANS_ID"];
    NSLog(@"播放达到激励条件 transid:%@", transId);
    // 发送激励事件
    FAQAdRewardEvent *event=[[FAQAdRewardEvent alloc] initWithAdId:self.posId transId:transId customData:self.customData userId:self.userId];
    [self sendEvent:event];
}

@end
