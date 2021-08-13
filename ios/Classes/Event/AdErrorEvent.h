//
//  AdErrorEvent.h
//  flutter_qq_ads
//
//  Created by zero on 2021/8/13.
//

#import "AdEvent.h"
// 广告错误事件
@interface AdErrorEvent : AdEvent
// 错误码
@property (assign, nonatomic) NSNumber* errCode;
// 错误信息
@property (copy,nonatomic) NSString *errMsg;

@end
