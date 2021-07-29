#import <Flutter/Flutter.h>
#import "GDTSDKConfig.h"
#import "GDTSplashAd.h"

@interface FlutterQqAdsPlugin : NSObject<FlutterPlugin,FlutterStreamHandler,GDTSplashAdDelegate>
@property (nonatomic, strong) GDTSplashAd *splashAd;
@property (nonatomic, strong) UIView *bottomView;
@end
