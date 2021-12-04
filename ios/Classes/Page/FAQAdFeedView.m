//
//  FAQAdFeedView.m
//  flutter_qq_ads
//
//  Created by zero on 2021/12/4.
//
#import "FAQAdFeedView.h"
#import "FAQFeedAdManager.h"
#import "GDTNativeExpressAd.h"
#import "GDTNativeExpressAdView.h"

@interface FAQAdFeedView()<FlutterPlatformView,GDTNativeExpressAdDelegete>
@property (strong,nonatomic) UIView *feedView;
@property (strong,nonatomic) GDTNativeExpressAdView *adView;
@property (strong,nonatomic) FlutterMethodChannel *methodChannel;

@end

@implementation FAQAdFeedView

- (instancetype)initWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger plugin:(FlutterQqAdsPlugin *)plugin{
    if(self==[super init]){
        self.viewId=viewId;
        self.feedView =[[UIView alloc] init];
        self.methodChannel = [FlutterMethodChannel methodChannelWithName:[NSString stringWithFormat:@"%@/%lli",kFAQAdFeedViewId,viewId] binaryMessenger:messenger];
        FlutterMethodCall *call= [FlutterMethodCall methodCallWithMethodName:@"AdFeedView" arguments:args];
        [self showAd:call eventSink:plugin.eventSink];
    }
    NSLog(@"%s %lli",__FUNCTION__,viewId);
    return self;
}

- (UIView *)view{
    return self.feedView;
}

- (void)dealloc{
    NSLog(@"%s",__FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 处理消息
- (void) postMsghandler:(NSNotification*) notification{
    NSString *name=notification.name;
    GDTNativeExpressAdView *loadAdView=notification.object;
    NSDictionary *userInfo=notification.userInfo;
    NSString *event=[userInfo objectForKey:@"event"];
    NSLog(@"%s postMsghandler name:%@ userInfo:%@",__FUNCTION__,name,userInfo);
    if([event isEqualToString:onAdPresent]){
        // 设置 Feed View 的大小与广告View 的实际大小一致
        self.feedView.frame=self.adView.frame;
        // 渲染成功，设置高度
        CGSize size= loadAdView.bounds.size;
        [self setFlutterViewSize:size];
    }else if([event isEqualToString:onAdClosed]||[event isEqualToString:onAdError]){
        // 关闭移除广告或出错，则设置大小为 0，隐藏广告
        [self.adView removeFromSuperview];
        [self setFlutterViewSize:CGSizeZero];
    }
}
// 设置 FlutterAds 视图宽高
- (void) setFlutterViewSize:(CGSize) size{
    NSNumber *width=[NSNumber numberWithFloat:size.width];
    NSNumber *height=[NSNumber numberWithFloat:size.height];
    NSDictionary *dicSize=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:width,height, nil] forKeys:[NSArray arrayWithObjects:@"width",@"height", nil]];
    // 通知 Flutter View 设置大小
    [self.methodChannel invokeMethod:@"setSize" arguments:dicSize];
}

- (void)loadAd:(FlutterMethodCall *)call{
    NSNumber *key=[NSNumber numberWithInteger:[self.posId integerValue]];
    NSString *name=[NSString stringWithFormat:@"%@/%@", kFAQAdFeedViewId, key.stringValue];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postMsghandler:) name:name object:nil];
    self.adView=[FAQFeedAdManager.share getAd:key];
    if(self.adView){
        self.adView.controller=self.rootController;
        [self.feedView addSubview:self.adView];
        [self.adView render];
    }
}

@end
