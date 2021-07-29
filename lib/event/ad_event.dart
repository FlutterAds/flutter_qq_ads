import 'package:flutter_qq_ads/event/ad_error_event.dart';

import 'ad_event_action.dart';

/// 广告事件
class AdEvent {
  AdEvent({this.adId, this.action});
  // 广告 id
  final String adId;
  // 操作
  final String action;

  /// 解析 AdEvent
  factory AdEvent.fromJson(Map<dynamic, dynamic> json) {
    String action = json['action'];
    if (action == AdEventAction.onAdError) {
      return AdErrorEvent.fromJson(json);
    } else {
      return AdEvent(
        adId: json['adId'],
        action: action,
      );
    }
  }
}
