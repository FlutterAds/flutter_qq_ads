//
//  InterstitialPage.h
//  flutter_qq_ads
//
//  Created by zero on 2021/8/18.
//

#import "BaseAdPage.h"
#import "GDTUnifiedInterstitialAd.h"
// 插屏广告
@interface InterstitialPage : BaseAdPage<GDTUnifiedInterstitialAdDelegate>
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
