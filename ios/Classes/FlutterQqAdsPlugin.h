#import <Flutter/Flutter.h>
#import "FAQSplashPage.h"
#import "FAQInterstitialPage.h"
#import "FAQRewardVideoPage.h"

@interface FlutterQqAdsPlugin : NSObject<FlutterPlugin,FlutterStreamHandler>
@property (strong, nonatomic) FlutterEventSink eventSink;
@property (strong, nonatomic) FAQSplashPage *sad;
@property (strong, nonatomic) FAQInterstitialPage *iad;
@property (strong, nonatomic) FAQRewardVideoPage *rvad;
@end
