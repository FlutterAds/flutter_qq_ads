#import <Flutter/Flutter.h>
#import "SplashPage.h"
#import "InterstitialPage.h"
#import "RewardVideoPage.h"

@interface FlutterQqAdsPlugin : NSObject<FlutterPlugin,FlutterStreamHandler>
@property (strong, nonatomic) FlutterEventSink eventSink;
@property (strong, nonatomic) SplashPage *sad;
@property (strong, nonatomic) InterstitialPage *iad;
@property (strong, nonatomic) RewardVideoPage *rvad;
@property (weak,nonatomic) NSString *posId;
@end
