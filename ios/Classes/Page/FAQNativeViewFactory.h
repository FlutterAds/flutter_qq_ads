//
//  FAQNativeViewFactory.h
//  flutter_qq_ads
//
//  Created by zero on 2021/8/31.
//
#import <Flutter/Flutter.h>
#import <Foundation/Foundation.h>
#import "FAQAdBannerView.h"

// AdBannerView
static NSString *const kAdBannerViewId=@"flutter_qq_ads_banner";

// 原生平台 View 工厂
@interface FAQNativeViewFactory : NSObject<FlutterPlatformViewFactory>
@property (strong,nonatomic) NSObject<FlutterBinaryMessenger> *messenger;
@property (strong,nonatomic) FlutterQqAdsPlugin *plugin;
- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger withPlugin:(FlutterQqAdsPlugin*) plugin;
@end
