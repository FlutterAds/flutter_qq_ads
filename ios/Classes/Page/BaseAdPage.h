//
//  BaseAdPage.h
//  flutter_qq_ads
//
//  Created by zero on 2021/8/18.
//
#import <Flutter/Flutter.h>
#import <Foundation/Foundation.h>
#import "AdEvent.h"
#import "AdErrorEvent.h"
#import "AdRewardEvent.h"
#import "AdEventAction.h"
// 基础广告页面
@interface BaseAdPage : NSObject
// 广告位id
@property (weak,nonatomic) NSString *posId;
// 事件消息
@property (strong, nonatomic) FlutterEventSink eventSink;
// 显示广告
- (void) showAd:(NSString *)posId methodCall:(FlutterMethodCall *)call eventSink:(nonnull FlutterEventSink) events;
// 加载广告
- (void) loadAd:(FlutterMethodCall *) call;
// 发送广告事件
-(void) sendEvent:(AdEvent *) event;
// 发送广告事件
-(void) sendEventAction:(NSString *) action;
// 发送广告错误事件
-(void) sendErrorEvent:(NSInteger) errCode withErrMsg:(NSString*) errMsg;
@end
