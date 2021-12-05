//
//  FAQAdFeedView.h
//  flutter_qq_ads
//
//  Created by zero on 2021/12/4.
//
#import "FAQBaseAdPage.h"
#import "FlutterQqAdsPlugin.h"
// 信息流广告 View
@interface FAQAdFeedView : FAQBaseAdPage<FlutterPlatformView>
@property (strong,nonatomic,nullable) FlutterQqAdsPlugin *plugin;
@property int64_t viewId;
- (nonnull instancetype) initWithFrame:(CGRect)frame
                        viewIdentifier:(int64_t)viewId
                             arguments:(id _Nullable)args
                       binaryMessenger:(NSObject<FlutterBinaryMessenger>* _Nullable)messenger plugin:(FlutterQqAdsPlugin* _Nullable) plugin;
- (nonnull UIView*) view;
@end
