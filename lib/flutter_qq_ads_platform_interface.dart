import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_qq_ads_method_channel.dart';
import 'event/ad_event_handler.dart';

abstract class FlutterQqAdsPlatform extends PlatformInterface {
  FlutterQqAdsPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterQqAdsPlatform _instance = MethodChannelFlutterQqAds();

  static FlutterQqAdsPlatform get instance => _instance;

  static set instance(FlutterQqAdsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> requestIDFA() {
    throw UnimplementedError('requestIDFA() has not been implemented.');
  }

  Future<bool> initAd(String appId) {
    throw UnimplementedError('initAd() has not been implemented.');
  }

  Future<bool> setPersonalizedState(int state) {
    throw UnimplementedError(
        'setPersonalizedState() has not been implemented.');
  }

  Future<bool> showSplashAd(String posId,
      {String? logo, double fetchDelay = 3}) {
    throw UnimplementedError('showSplashAd() has not been implemented.');
  }

  Future<bool> showInterstitialAd(
    String posId, {
    bool showPopup = false,
    bool showFullScreenVideo = false,
    bool showRewardVideo = false,
    bool autoPlayOnWifi = false,
    bool autoPlayMuted = true,
    String? customData,
    String? userId,
  }) {
    throw UnimplementedError('showInterstitialAd() has not been implemented.');
  }

  Future<bool> showRewardVideoAd(
    String posId, {
    bool playMuted = false,
    String? customData,
    String? userId,
  }) {
    throw UnimplementedError('showRewardVideoAd() has not been implemented.');
  }

  Future<List<int>> loadFeedAd(String posId,
      {int width = 375, int height = 0, int count = 1}) {
    throw UnimplementedError('loadFeedAd() has not been implemented.');
  }

  Future<bool> clearFeedAd(List<int> list) {
    throw UnimplementedError('clearFeedAd() has not been implemented.');
  }

  Future<String> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> onEventListener(OnAdEventListener onAdEventListener) {
    throw UnimplementedError('onEventListener() has not been implemented.');
  }
}
