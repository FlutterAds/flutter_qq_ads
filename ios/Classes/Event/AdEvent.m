//
//  AdEvent.m
//  flutter_qq_ads
//
//  Created by zero on 2021/8/13.
//

#import "AdEvent.h"

@implementation AdEvent

- (NSDictionary *)toMap{
    NSDictionary *data=@{@"adId":_adId,@"action":_action};
    return data;
}

@end
