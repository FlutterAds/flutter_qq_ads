//
//  FAQNativeViewFactory.h
//  flutter_qq_ads
//
//  Created by zero on 2021/8/31.
//
#import <Flutter/Flutter.h>
#import <Foundation/Foundation.h>
#import "FAQAdBannerView.h"
#import "FAQAdFeedView.h"

// 原生平台 View 工厂
@interface FAQNativeViewFactory : NSObject<FlutterPlatformViewFactory>
@property (strong,nonatomic) NSObject<FlutterBinaryMessenger> *messenger;
@property (strong,nonatomic) FlutterQqAdsPlugin *plugin;
@property (strong,nonatomic) NSString *viewName;
- (instancetype)initWithViewName:(NSString*) viewName withMessenger:(NSObject<FlutterBinaryMessenger>*)messenger withPlugin:(FlutterQqAdsPlugin*) plugin;
@end
