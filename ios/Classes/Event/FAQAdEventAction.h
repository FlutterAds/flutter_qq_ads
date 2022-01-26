//
//  FAQAdEventAction.h
//  flutter_qq_ads
//
//  Created by zero on 2021/8/14.
//

#import <Foundation/Foundation.h>
// 广告错误
static NSString *const onAdError=@"onAdError";
// 广告加载成功
static NSString *const onAdLoaded=@"onAdLoaded";
// 广告填充
static NSString *const onAdPresent=@"onAdPresent";
// 广告曝光
static NSString *const onAdExposure=@"onAdExposure";
// 广告关闭（计时结束或者用户点击关闭）
static NSString *const onAdClosed=@"onAdClosed";
// 广告点击
static NSString *const onAdClicked=@"onAdClicked";
// 广告跳过
static NSString *const onAdSkip=@"onAdSkip";
// 广告播放或计时完毕
static NSString *const onAdComplete=@"onAdComplete";
// 获得广告激励
static NSString *const onAdReward=@"onAdReward";
// 广告事件操作
@interface FAQAdEventAction : NSObject
@end
