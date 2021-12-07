//
//  FAQFeedAdLoad.h
//  flutter_qq_ads
//
//  Created by zero on 2021/12/4.
//

#import <Foundation/Foundation.h>
#import "FAQBaseAdPage.h"

@interface FAQFeedAdLoad :FAQBaseAdPage
@property (strong,nonatomic,nonnull) FlutterResult result;
// 加载信息流广告列表
-(void) loadFeedAdList:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult) result eventSink:(nonnull FlutterEventSink )events;
@end
