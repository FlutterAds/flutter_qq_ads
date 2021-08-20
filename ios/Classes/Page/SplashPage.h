//
//  SplashPage.h
//  flutter_qq_ads
//
//  Created by zero on 2021/8/18.
//

#import "BaseAdPage.h"
#import "GDTSplashAd.h"
// 开屏广告
@interface SplashPage : BaseAdPage <GDTSplashAdDelegate>
@property (strong, nonatomic) GDTSplashAd *splashAd;
@property (retain, nonatomic) UIView *bottomView;
@property (nonatomic, assign) BOOL fullScreenAd;
@end
