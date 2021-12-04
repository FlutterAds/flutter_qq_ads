//
//  FAQFeedAdManager.m
//  flutter_qq_ads
//
//  Created by zero on 2021/12/4.
//

#import "FAQFeedAdManager.h"

@implementation FAQFeedAdManager

static FAQFeedAdManager *adManager;// 广告管理实例
NSMutableDictionary *adList;// 已加载信息流广告列表

+ (instancetype)share{
    dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        adList = [[NSMutableDictionary alloc] init];
        adManager=[[FAQFeedAdManager alloc] init];
    });
    return adManager;
}

- (void)putAd:(NSNumber *)key value:(GDTNativeExpressAdView *)value{
    [adList setObject:value forKey:key];
}

- (GDTNativeExpressAdView *)getAd:(NSNumber *)key{
    return [adList objectForKey:key];
}

- (void)removeAd:(NSNumber *)key{
    [adList removeObjectForKey:key];
}

@end
