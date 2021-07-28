import 'dart:async';

import 'package:flutter/services.dart';

/// 腾讯广告 Flutter 插件
class FlutterQqAds {
  // 方法通道
  static const MethodChannel _methodChannel =
      const MethodChannel('flutter_qq_ads');
  // 事件通道
  static const EventChannel _eventChannel =
      const EventChannel('flutter_qq_ads_event');

  /// 初始化广告
  /// [appId] 广告配置 appId
  static Future<bool> initAd(String appId) async {
    final bool result = await _methodChannel.invokeMethod(
      'initAd',
      {'appId': appId},
    );
    return result;
  }

  /// 展示开屏广告
  /// [posId] 广告位 id
  /// [logo] 展示如果传递则展示底部logo，不传递不展示，则全屏
  static Future<bool> showSplashAd(String posId, [String logo]) async {
    final bool result = await _methodChannel.invokeMethod(
      'showSplashAd',
      {
        'posId': posId,
        'logo': logo,
      },
    );
    return result;
  }

  static Future<String> get platformVersion async {
    final String version =
        await _methodChannel.invokeMethod('getPlatformVersion');
    return version;
  }
}
