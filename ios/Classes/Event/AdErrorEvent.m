//
//  AdErrorEvent.m
//  flutter_qq_ads
//
//  Created by zero on 2021/8/13.
//

#import "AdErrorEvent.h"
#import "AdEventAction.h"

@implementation AdErrorEvent

- (id)initWithAdId:(NSString *)adId errCode:(NSInteger *)errCode errMsg:(NSString *)errMsg{
//    [super initWithAdId:adId andAction:action];
    self.adId=adId;
    self.action=onAdError;
    self.errCode=errCode;
    self.errMsg=errMsg;
    return self;
}

- (NSDictionary *)toMap{
    NSDictionary *data=[super toMap];
    [data setValue:_errMsg forKey:@"errMsg"];
    [data setValue:[NSNumber numberWithInteger:_errCode] forKey:@"errCode"];
    
    return data;
}
@end
