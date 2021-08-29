import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_qq_ads/flutter_qq_ads.dart';

import 'ads_config.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_qq_ads');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall call) async {
      String method = call.method;
      if (method == 'initAd') {
        String appId = call.arguments['appId'] ?? '';
        return appId.isNotEmpty;
      } else if (method == 'showSplashAd') {
        String posId = call.arguments['posId'] ?? '';
        return posId.isNotEmpty;
      } else if (method == 'showInterstitialAd') {
        String posId = call.arguments['posId'] ?? '';
        return posId.isNotEmpty;
      } else if (method == 'showRewardVideoAd') {
        String posId = call.arguments['posId'] ?? '';
        return posId.isNotEmpty;
      }
      return false;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('initAd', () async {
    expect(await FlutterQqAds.initAd(AdsConfig.appId), true);
  });
  test('showSplashAd', () async {
    expect(await FlutterQqAds.showSplashAd(AdsConfig.splashId), true);
  });
  test('showInterstitialAd', () async {
    expect(
        await FlutterQqAds.showInterstitialAd(AdsConfig.interstitialId), true);
    expect(
        await FlutterQqAds.showInterstitialAd(
            AdsConfig.interstitialFullScreenVideoId),
        true);
    expect(
        await FlutterQqAds.showInterstitialAd(
            AdsConfig.interstitialRewardVideoId),
        true);
  });
  test('showRewardVideoAd', () async {
    expect(await FlutterQqAds.showRewardVideoAd(AdsConfig.rewardVideoId), true);
  });
}
