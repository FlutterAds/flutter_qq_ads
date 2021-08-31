//
//  AdBannerView.m
//  flutter_qq_ads
//
//  Created by zero on 2021/8/31.
//

#import "AdBannerView.h"
#import "GDTUnifiedBannerView.h"
// Banner 广告 View
@interface AdBannerView()<FlutterPlatformView,GDTUnifiedBannerViewDelegate>
@property (strong,nonatomic) GDTUnifiedBannerView *bannerView;
@end
// Banner 广告 View
@implementation AdBannerView
- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger
                       plugin:(FlutterQqAdsPlugin*) plugin{
    if (self = [super init]) {
        self.args=args;
        NSString* posId = args[@"posId"];
        [self showAd:posId methodCall:nil eventSink:plugin.eventSink];
    }
    return self;
}

- (UIView*)view {
    return self.bannerView;
}
// 加载广告
- (void)loadAd:(FlutterMethodCall *)call{
    // 刷新间隔
    int interval=[self.args[@"interval"] intValue];
    // 创建 Banner
    self.bannerView=[[GDTUnifiedBannerView alloc] initWithPlacementId:self.posId viewController:self.rootController];
    // 设置 Delegate
    self.bannerView.delegate=self;
    // 这里处理如果刷新间隔不为 0，则展示动画
    self.bannerView.animated=interval!=0;
    // 设置刷新间隔
    self.bannerView.autoSwitchInterval=interval;
    // 加载动画
    [self.bannerView loadAdAndShow];
}


#pragma mark - GDTUnifiedBannerViewDelegate
/**
 *  请求广告条数据成功后调用
 *  当接收服务器返回的广告数据成功后调用该函数
 */
- (void)unifiedBannerViewDidLoad:(GDTUnifiedBannerView *)unifiedBannerView
{
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self sendEventAction:onAdLoaded];
}

/**
 *  请求广告条数据失败后调用
 *  当接收服务器返回的广告数据失败后调用该函数
 */

- (void)unifiedBannerViewFailedToLoad:(GDTUnifiedBannerView *)unifiedBannerView error:(NSError *)error
{
    NSLog(@"%s%@",__FUNCTION__,error);
    // 发送广告错误事件
    [self sendErrorEvent:error.code withErrMsg:error.localizedDescription];
}

/**
 *  banner2.0曝光回调
 */
- (void)unifiedBannerViewWillExpose:(nonnull GDTUnifiedBannerView *)unifiedBannerView {
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self sendEventAction:onAdExposure];
}

/**
 *  banner2.0点击回调
 */
- (void)unifiedBannerViewClicked:(GDTUnifiedBannerView *)unifiedBannerView
{
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self sendEventAction:onAdClicked];
}

/**
 *  应用进入后台时调用
 *  当点击应用下载或者广告调用系统程序打开，应用将被自动切换到后台
 */
- (void)unifiedBannerViewWillLeaveApplication:(GDTUnifiedBannerView *)unifiedBannerView
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  全屏广告页已经被关闭
 */
- (void)unifiedBannerViewDidDismissFullScreenModal:(GDTUnifiedBannerView *)unifiedBannerView
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  全屏广告页即将被关闭
 */
- (void)unifiedBannerViewWillDismissFullScreenModal:(GDTUnifiedBannerView *)unifiedBannerView
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  banner2.0广告点击以后即将弹出全屏广告页
 */
- (void)unifiedBannerViewWillPresentFullScreenModal:(GDTUnifiedBannerView *)unifiedBannerView
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  banner2.0广告点击以后弹出全屏广告页完毕
 */
- (void)unifiedBannerViewDidPresentFullScreenModal:(GDTUnifiedBannerView *)unifiedBannerView
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  banner2.0被用户关闭时调用
 */
- (void)unifiedBannerViewWillClose:(nonnull GDTUnifiedBannerView *)unifiedBannerView {
    self.bannerView = nil;
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self sendEventAction:onAdClicked];
}
@end
