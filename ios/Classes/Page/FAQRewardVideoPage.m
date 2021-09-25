//
//  FAQRewardVideoPage.m
//  flutter_qq_ads
//
//  Created by zero on 2021/8/19.
//

#import "FAQRewardVideoPage.h"
#import "GDTRewardVideoAd.h"
// 激励视频页面
@interface FAQRewardVideoPage()<GDTRewardedVideoAdDelegate>
@property (nonatomic, strong) GDTRewardVideoAd *rvad;
// 服务端验证的自定义信息
@property (copy,nonatomic) NSString *customData;
// 服务端验证的用户信息
@property (copy,nonatomic) NSString *userId;
@end

@implementation FAQRewardVideoPage
// 加载广告
- (void)loadAd:(FlutterMethodCall *)call{
    BOOL playMuted=[call.arguments[@"playMuted"] boolValue];
    self.customData = call.arguments[@"customData"] ;
    self.userId = call.arguments[@"userId"];
    // 初始化激励视频广告
    self.rvad= [[GDTRewardVideoAd alloc] initWithPlacementId:self.posId];
    self.rvad.delegate=self;
    self.rvad.videoMuted=playMuted;
    //如果设置了服务端验证，可以设置serverSideVerificationOptions属性
    GDTServerSideVerificationOptions *ssv = [[GDTServerSideVerificationOptions alloc] init];
    ssv.userIdentifier = self.userId;
    ssv.customRewardString = self.customData;
    self.rvad.serverSideVerificationOptions = ssv;
    [self.rvad loadAd];
}


#pragma mark - GDTRewardVideoAdDelegate
- (void)gdt_rewardVideoAdDidLoad:(GDTRewardVideoAd *)rewardedVideoAd
{
    NSLog(@"%s",__FUNCTION__);
    UIViewController* controller = [UIApplication sharedApplication].keyWindow.rootViewController;
    [self.rvad showAdFromRootViewController:controller];
    // 发送广告事件
    [self sendEventAction:onAdLoaded];
}


- (void)gdt_rewardVideoAdVideoDidLoad:(GDTRewardVideoAd *)rewardedVideoAd
{
    NSLog(@"%s",__FUNCTION__);
}


- (void)gdt_rewardVideoAdWillVisible:(GDTRewardVideoAd *)rewardedVideoAd
{
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self sendEventAction:onAdPresent];
}

- (void)gdt_rewardVideoAdDidExposed:(GDTRewardVideoAd *)rewardedVideoAd
{
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"广告已曝光");
    // 发送广告事件
    [self sendEventAction:onAdExposure];
}

- (void)gdt_rewardVideoAdDidClose:(GDTRewardVideoAd *)rewardedVideoAd
{
    NSLog(@"%s",__FUNCTION__);
    
    NSLog(@"广告已关闭");
    // 发送广告事件
    [self sendEventAction:onAdClosed];
}


- (void)gdt_rewardVideoAdDidClicked:(GDTRewardVideoAd *)rewardedVideoAd
{
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"广告已点击");
    // 发送广告事件
    [self sendEventAction:onAdClicked];
}

- (void)gdt_rewardVideoAd:(GDTRewardVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error
{
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"ERROR: %@", error);
    // 发送广告错误事件
    [self sendErrorEvent:error.code withErrMsg:error.localizedDescription];
}

- (void)gdt_rewardVideoAdDidRewardEffective:(GDTRewardVideoAd *)rewardedVideoAd info:(NSDictionary *)info {
    NSLog(@"%s",__FUNCTION__);
    NSString *transId=[info objectForKey:@"GDT_TRANS_ID"];
    NSLog(@"播放达到激励条件 transid:%@", transId);
    // 发送激励事件
    FAQAdRewardEvent *event=[[FAQAdRewardEvent alloc] initWithAdId:self.posId transId:transId customData:self.customData userId:self.userId];
    [self sendEvent:event];
}

- (void)gdt_rewardVideoAdDidPlayFinish:(GDTRewardVideoAd *)rewardedVideoAd
{
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"视频播放结束");
}
@end
