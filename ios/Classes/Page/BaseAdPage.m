//
//  BaseAdPage.m
//  flutter_qq_ads
//
//  Created by zero on 2021/8/18.
//

#import "BaseAdPage.h"

@implementation BaseAdPage
// 添加广告事件
-(void) addAdEvent:(AdEvent *) event{
    if(self.eventSink!=nil){
        self.eventSink([event toMap]);
    }
}
// 显示广告
-(void)showAd:(NSString *)posId methodCall:(FlutterMethodCall *)call eventSink:(nonnull FlutterEventSink )events{
    self.posId=posId;
    self.eventSink=events;
    [self loadAd:call];
}


@end
