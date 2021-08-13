//
//  AdErrorEvent.m
//  flutter_qq_ads
//
//  Created by zero on 2021/8/13.
//

#import "AdErrorEvent.h"

@implementation AdErrorEvent

- (NSDictionary *)toMap{
    NSDictionary *data=[super toMap];
    [data setValue:_errCode forKey:@"errCode"];
    [data setValue:_errMsg forKey:@"errMsg"];
    return data;
}
@end
