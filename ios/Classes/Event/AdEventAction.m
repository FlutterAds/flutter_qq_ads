//
//  AdEventAction.m
//  flutter_qq_ads
//
//  Created by zero on 2021/8/14.
//

#import "AdEventAction.h"
// 广告事件操作
@implementation AdEventAction
// 广告错误
NSString *const onAdError=@"onAdError";
// 广告加载成功
NSString *const onAdLoaded=@"onAdLoaded";
// 广告填充
NSString *const onAdPresent=@"onAdPresent";
// 广告曝光
NSString *const onAdExposure=@"onAdExposure";
// 广告关闭（计时结束或者用户点击关闭）
NSString *const onAdClosed=@"onAdClosed";
// 广告点击
NSString *const onAdClicked=@"onAdClicked";

@end
