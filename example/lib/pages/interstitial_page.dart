import 'package:flutter/material.dart';
import 'package:flutter_qq_ads/flutter_qq_ads.dart';

import '../ads_config.dart';
import '../theme/style.dart';
import '../widgets/widgets.dart';

// 插屏视频
class InterstitialPage extends StatefulWidget {
  const InterstitialPage({Key? key}) : super(key: key);

  @override
  _InterstitialPageState createState() => _InterstitialPageState();
}

class _InterstitialPageState extends State<InterstitialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, '插屏广告'),
      body: Column(
        children: [
          ListTile(
            title: Text('插屏-半屏'),
            onTap: () => showInterstitialAd(AdsConfig.interstitialId),
          ),
          kDivider,
          ListTile(
            title: Text('插屏-全屏'),
            onTap: () => showInterstitialAd(
                AdsConfig.interstitialFullScreenVideoId,
                showFullScreenVideo: true),
          ),
          kDivider,
          ListTile(
            title: Text('插屏-激励视频'),
            onTap: () => showInterstitialAd(AdsConfig.interstitialRewardVideoId,
                showRewardVideo: true),
          ),
          kDivider,
        ],
      ),
    );
  }

  /// 展示插屏广告
  Future<void> showInterstitialAd(String posId,
      {bool showFullScreenVideo = false, bool showRewardVideo = false}) async {
    bool result = await FlutterQqAds.showInterstitialAd(
      posId,
      showPopup: false,
      showFullScreenVideo: showFullScreenVideo,
      showRewardVideo: showRewardVideo,
      autoPlayMuted: false,
      autoPlayOnWifi: false,
      detailPageMuted: false,
      userId: 'userId',
      customData: 'showInterstitialAd customData',
    );
    print("展示插屏广告${result ? '成功' : '失败'}");
  }
}
