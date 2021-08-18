//
//  BaseAdPage.m
//  flutter_qq_ads
//
//  Created by zero on 2021/8/18.
//

#import "BaseAdPage.h"

@implementation BaseAdPage
- (void)showAd:(NSString *)posId methodCall:(FlutterMethodCall *)call{
    self.posId=posId;
    [self loadAd:call];
}
@end
