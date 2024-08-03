import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

import 'event/ad_event_handler.dart';

export 'event/ad_event_handler.dart';
export 'view/ad_banner_widget.dart';
export 'view/ad_feed_widget.dart';

/// 腾讯广告 Flutter 插件
class FlutterQqAds {
  // 方法通道
  static const MethodChannel _methodChannel =
      const MethodChannel('flutter_qq_ads');
  // 事件通道
  static const EventChannel _eventChannel =
      const EventChannel('flutter_qq_ads_event');

  /// 请求应用跟踪透明度授权
  static Future<bool> get requestIDFA async {
    if (Platform.isIOS) {
      final bool result = await _methodChannel.invokeMethod('requestIDFA');
      return result;
    }
    return true;
  }

  /// 初始化广告
  /// [appId] 应用媒体ID
  static Future<bool> initAd(String appId) async {
    final bool result = await _methodChannel.invokeMethod(
      'initAd',
      {'appId': appId},
    );
    return result;
  }

  /// 设置个性化广告
  /// 0：代表开启个性化广告推荐，1：代表关闭个性化广告推荐
  static Future<bool> setPersonalizedState(int state) async {
    final bool result = await _methodChannel.invokeMethod(
      'setPersonalizedState',
      {'state': state},
    );
    return result;
  }

  /// 展示开屏广告
  /// [posId] 广告位 id
  /// [logo] 如果传值则展示底部logo，不传不展示，则全屏展示
  /// [fetchDelay] 拉取广告的超时时间，默认值 3 秒，取值范围[1.5~5]秒
  static Future<bool> showSplashAd(String posId,
      {String? logo, double fetchDelay = 3}) async {
    final bool result = await _methodChannel.invokeMethod(
      'showSplashAd',
      {
        'posId': posId,
        'logo': logo,
        'fetchDelay': fetchDelay,
      },
    );
    return result;
  }

  /// 展示插屏广告
  /// [posId] 广告位 id
  /// [showPopup] Popup 形式显示（仅 Android）
  /// [showFullScreenVideo] 插屏全屏视频形式显示
  /// [showRewardVideo] 插屏激励视频形式显示
  /// [autoPlayOnWifi] 是否仅在 WiFi 网络下自动播放
  /// [autoPlayMuted] 自动播放是否静音
  /// [customData] 设置服务端验证的自定义信息
  /// [userId] 设置服务端验证的用户信息
  static Future<bool> showInterstitialAd(
    String posId, {
    bool showPopup = false,
    bool showFullScreenVideo = false,
    bool showRewardVideo = false,
    bool autoPlayOnWifi = false,
    bool autoPlayMuted = true,
    String? customData,
    String? userId,
  }) async {
    final bool result = await _methodChannel.invokeMethod(
      'showInterstitialAd',
      {
        'posId': posId,
        'showPopup': showPopup,
        'showFullScreenVideo': showFullScreenVideo,
        'showRewardVideo': showRewardVideo,
        'autoPlayOnWifi': autoPlayOnWifi,
        'autoPlayMuted': autoPlayMuted,
        'customData': customData,
        'userId': userId,
      },
    );
    return result;
  }

  /// 展示激励视频广告
  /// [posId] 广告位 id
  /// [playMuted] 是否静音播放
  /// [customData] 设置服务端验证的自定义信息
  /// [userId] 设置服务端验证的用户信息
  static Future<bool> showRewardVideoAd(
    String posId, {
    bool playMuted = false,
    String? customData,
    String? userId,
  }) async {
    final bool result = await _methodChannel.invokeMethod(
      'showRewardVideoAd',
      {
        'posId': posId,
        'playMuted': playMuted,
        'customData': customData,
        'userId': userId,
      },
    );
    return result;
  }

  /// 加载信息流广告列表
  /// [posId] 广告位 id
  /// [width] 宽度
  /// [height] 高度，0：代表自适应广告高度
  /// [count] 获取广告数量，建议 1~3 个
  static Future<List<int>> loadFeedAd(String posId,
      {int width = 375, int height = 0, int count = 1}) async {
    final List<dynamic> result = await _methodChannel.invokeMethod(
      'loadFeedAd',
      {
        'posId': posId,
        'width': width,
        'height': height,
        'count': count,
      },
    );
    return List<int>.from(result);
  }

  /// 清除信息流广告列表
  /// [list] 信息流广告 id 列表
  static Future<bool> clearFeedAd(List<int> list) async {
    final bool result = await _methodChannel.invokeMethod(
      'clearFeedAd',
      {
        'list': list,
      },
    );
    return result;
  }

  static Future<String> get platformVersion async {
    final String version =
        await _methodChannel.invokeMethod('getPlatformVersion');
    return version;
  }

  ///事件回调
  ///@params onData 事件回调
  static Future<void> onEventListener(
      OnAdEventListener onAdEventListener) async {
    _eventChannel.receiveBroadcastStream().listen((data) {
      hanleAdEvent(data, onAdEventListener);
    });
  }
}
