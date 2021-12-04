//
//  FAQFeedAdLoad.m
//  flutter_qq_ads
//
//  Created by zero on 2021/12/4.
//

#import "FAQFeedAdLoad.h"
#import "FAQFeedAdManager.h"
#import "FlutterQqAdsPlugin.h"

@interface FAQFeedAdLoad()<GDTNativeExpressAdDelegete>
@property (strong,nonatomic) GDTNativeExpressAd *ad;

@end

@implementation FAQFeedAdLoad

- (void)loadFeedAdList:(FlutterMethodCall *)call result:(FlutterResult)result eventSink:(FlutterEventSink)events{
    self.result=result;
    [self showAd:call eventSink:events];
}

- (void)loadAd:(FlutterMethodCall *)call{
    int width = [call.arguments[@"width"] intValue];
    int height = [call.arguments[@"height"] intValue];
    int count = [call.arguments[@"count"] intValue];
    
    CGSize size= CGSizeMake(width, height);
    
    self.ad=[[GDTNativeExpressAd alloc] initWithPlacementId:self.posId adSize:size];
    self.ad.delegate=self;
    [self.ad loadAd:count];
}

#pragma mark - GDTNativeExpressAdDelegete

- (void)nativeExpressAdSuccessToLoad:(GDTNativeExpressAd *)nativeExpressAd views:(NSArray<__kindof GDTNativeExpressAdView *> *)views{
    NSLog(@"%s",__FUNCTION__);
    if (views.count) {
        // 广告列表，用于返回 Flutter 层
        NSMutableArray *adList= [[NSMutableArray alloc] init];
        [views enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // 通过hash 来标识不同的原生广告 View
            NSNumber *key=[NSNumber numberWithInteger:[obj hash]];
            NSLog(@"FeedAdLoad idx:%lu obj:%p hash:%@",(unsigned long)[obj hash],obj,key);
            // 添加到返回列表中
            [adList addObject:key];
            // 添加到缓存广告列表中
            [FAQFeedAdManager.share putAd:key value:obj];
        }];
        // 返回广告列表
        self.result(adList);
    }
    // 发送广告事件
    [self sendEventAction:onAdLoaded];
}

- (void)nativeExpressAdFailToLoad:(GDTNativeExpressAd *)nativeExpressAd error:(NSError *)error{
    NSLog(@"%s error:%@",__FUNCTION__,error);
    self.result(@[]);
}

- (void)nativeExpressAdViewRenderSuccess:(GDTNativeExpressAdView *)nativeExpressAdView{
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self sendEventAction:onAdExposure];
    // 渲染成功，发送更新展示通知，来更新尺寸
    [self postNotificationMsg:nativeExpressAdView userInfo:[NSDictionary dictionaryWithObject:onAdExposure forKey:@"event"]];
}

- (void)nativeExpressAdViewRenderFail:(GDTNativeExpressAdView *)nativeExpressAdView{
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressAdViewExposure:(GDTNativeExpressAdView *)nativeExpressAdView{
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressAdViewClicked:(GDTNativeExpressAdView *)nativeExpressAdView{
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressAdViewClosed:(GDTNativeExpressAdView *)nativeExpressAdView{
    NSLog(@"%s",__FUNCTION__);
}

// 发送消息
// 这里发送消息到信息流View，主要是适配信息流 View 的尺寸
- (void) postNotificationMsg:(GDTNativeExpressAdView *) adView userInfo:(NSDictionary *) userInfo{
    NSLog(@"%s",__FUNCTION__);
    NSNumber *key=[NSNumber numberWithInteger:[adView hash]];
    NSString *name=[NSString stringWithFormat:@"%@/%@", kFAQAdFeedViewId, key.stringValue];
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:adView userInfo:userInfo];
}

@end
