//
//  FAQFeedAdManager.m
//  flutter_qq_ads
//
//  Created by zero on 2021/12/4.
//

#import "FAQFeedAdManager.h"

@implementation FAQFeedAdManager

static FAQFeedAdManager *adManager;// 广告管理实例
NSMutableDictionary *faqAdList;// 已加载信息流广告列表

+ (instancetype)share{
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        faqAdList = [[NSMutableDictionary alloc] init];
        adManager=[[FAQFeedAdManager alloc] init];
    });
    return adManager;
}

- (void)putAd:(NSNumber *)key value:(id)value{
    [faqAdList setObject:value forKey:key];
}

- (id)getAd:(NSNumber *)key{
    return [faqAdList objectForKey:key];
}

- (void)removeAd:(NSNumber *)key{
    [faqAdList removeObjectForKey:key];
}

@end
