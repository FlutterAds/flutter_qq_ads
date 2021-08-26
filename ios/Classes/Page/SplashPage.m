//
//  SplashPage.m
//  flutter_qq_ads
//
//  Created by zero on 2021/8/18.
//

#import "SplashPage.h"
#import "GDTSplashAd.h"
// 开屏广告
@interface SplashPage()<GDTSplashAdDelegate>
@property (strong, nonatomic) GDTSplashAd *splashAd;
@property (retain, nonatomic) UIView *bottomView;
@property (nonatomic, assign) BOOL fullScreenAd;
@end

@implementation SplashPage
// 加载广告
-(void)loadAd:(FlutterMethodCall *)call{
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
    // 发送广告事件
    [self sendEventAction:onAdLoaded];
}

- (void)splashAdSuccessPresentScreen:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self sendEventAction:onAdPresent];
}

- (void)splashAdFailToPresent:(GDTSplashAd *)splashAd withError:(NSError *)error
{
    NSLog(@"%s%@",__FUNCTION__,error);
    // 发送广告错误事件
    [self sendErrorEvent:error.code withErrMsg:error.localizedDescription];
}

- (void)splashAdExposured:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self sendEventAction:onAdExposure];
}

- (void)splashAdClicked:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self sendEventAction:onAdClicked];
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
    // 发送广告事件
    [self sendEventAction:onAdClosed];
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

@end
