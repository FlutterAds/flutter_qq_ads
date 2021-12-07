//
//  FAQFeedAdManager.h
//  flutter_qq_ads
//
//  Created by zero on 2021/12/4.
//

#import <Foundation/Foundation.h>
// 信息流广告管理
@interface FAQFeedAdManager : NSObject
// 单利类方法
+ (instancetype) share;
// 加入到缓存中
- (void) putAd:(NSNumber *) key value:(id) value;
// 从缓存中获取
- (id) getAd:(NSNumber *) key;
// 从缓存中删除
- (void) removeAd:(NSNumber *) key;
@end
