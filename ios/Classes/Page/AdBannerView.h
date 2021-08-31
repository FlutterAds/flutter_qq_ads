//
//  AdBannerView.h
//  flutter_qq_ads
//
//  Created by zero on 2021/8/31.
//

#import "BaseAdPage.h"
#import "FlutterQqAdsPlugin.h"
@interface AdBannerView : BaseAdPage<FlutterPlatformView>
@property (strong,nonatomic) FlutterQqAdsPlugin *plugin;
- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger plugin:(FlutterQqAdsPlugin*) plugin;

- (UIView*)view;
@end
