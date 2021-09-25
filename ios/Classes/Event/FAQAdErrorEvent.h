//
//  FAQAdErrorEvent.h
//  flutter_qq_ads
//
//  Created by zero on 2021/8/13.
//

#import "FAQAdEvent.h"
// 广告错误事件
@interface FAQAdErrorEvent : FAQAdEvent
// 错误码
@property (assign, nonatomic) NSNumber* errCode;
// 错误信息
@property (copy,nonatomic) NSString *errMsg;
// 构造广告错误事件
-(id) initWithAdId:(NSString *)adId errCode:(NSNumber *)errCode errMsg:(NSString *)errMsg;

@end
