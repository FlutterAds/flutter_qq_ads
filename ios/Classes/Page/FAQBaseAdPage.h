//
//  FAQBaseAdPage.h
//  flutter_qq_ads
//
//  Created by zero on 2021/8/18.
//
#import <Flutter/Flutter.h>
#import <Foundation/Foundation.h>
#import "FAQAdEvent.h"
#import "FAQAdErrorEvent.h"
#import "FAQAdRewardEvent.h"
#import "FAQAdEventAction.h"
// 广告位id
static NSString *const kPosId=@"posId";

// 基础广告页面
@interface FAQBaseAdPage : NSObject
// 广告位id
@property (weak,nonatomic) NSString *posId;
// 事件消息
@property (strong, nonatomic) FlutterEventSink eventSink;
// Window
@property (strong,nonatomic) UIWindow *mainWin;
// 根控制器
@property (strong,nonatomic) UIViewController *rootController;
// 屏幕宽度
@property CGFloat width;
// 屏幕高度
@property CGFloat height;
// 显示广告
- (void) showAd:(FlutterMethodCall *)call eventSink:(nonnull FlutterEventSink) events;
// 加载广告
- (void) loadAd:(FlutterMethodCall *) call;
// 发送广告事件
-(void) sendEvent:(FAQAdEvent *) event;
// 发送广告事件
-(void) sendEventAction:(NSString *) action;
// 发送广告错误事件
-(void) sendErrorEvent:(NSInteger) errCode withErrMsg:(NSString*) errMsg;
@end
