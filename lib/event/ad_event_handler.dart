import 'package:flutter_qq_ads/event/ad_event.dart';

/// 广告事件回调监听
typedef OnAdEventListener = void Function(AdEvent event);

/// 处理广告事件
void hanleAdEvent(dynamic data, OnAdEventListener listener) {
  if (data != null) {
    AdEvent adEvent = AdEvent.fromJson(data);
    listener?.call(adEvent);
  }
}
