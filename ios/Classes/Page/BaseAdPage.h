//
//  BaseAdPage.h
//  flutter_qq_ads
//
//  Created by zero on 2021/8/18.
//
#import <Flutter/Flutter.h>
#import <Foundation/Foundation.h>
// 基础广告页面
@interface BaseAdPage : NSObject
// 广告位id
@property (weak,nonatomic) NSString *posId;
// 显示广告
- (void) showAd:(NSString *)posId methodCall:(FlutterMethodCall *)call;
// 加载广告
- (void) loadAd:(FlutterMethodCall *) call;
@end
