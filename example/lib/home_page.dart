import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qq_ads/flutter_qq_ads.dart';

import 'ads_config.dart';
import 'feed_page.dart';

// 结果信息
String _result = '';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _adEvent = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterAds QQ plugin'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 10),
              Text('Result: $_result'),
              SizedBox(height: 10),
              Text('onAdEvent: $_adEvent'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    child: Text('初始化'),
                    onPressed: () {},
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text('请求跟踪授权'),
                    onPressed: () {
                      requestIDFA();
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text('个性化广告'),
                    onPressed: () {
                      setPersonalizedAd(1);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    child: Text('开屏(Logo2)'),
                    onPressed: () {
                      showSplashAd(AdsConfig.logo2);
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text('开屏(全屏)'),
                    onPressed: () {
                      showSplashAd();
                      setState(() {});
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    child: Text('插屏广告'),
                    onPressed: () {
                      showInterstitialAd(AdsConfig.interstitialId);
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text('插全屏广告'),
                    onPressed: () {
                      showInterstitialAd(
                        AdsConfig.interstitialFullScreenVideoId,
                        showFullScreenVideo: true,
                      );
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    child: Text('插屏激励'),
                    onPressed: () {
                      showInterstitialAd(
                        AdsConfig.interstitialRewardVideoId,
                        showFullScreenVideo: true,
                        showRewardVideo: true,
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text('激励视频'),
                    onPressed: () {
                      showRewardVideoAd();
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('信息流'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FeedPage(),
                      ));
                },
              ),
              SizedBox(height: 20),
              const Center(child: Text('👇🏻 Banner 广告 👇🏻')),
              const SizedBox(height: 10),
              AdBannerWidget(
                posId: AdsConfig.bannerId,
                width: 300,
                height: 80,
                interval: 0,
                show: true,
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  /// 设置广告监听
  Future<void> setAdEvent() async {
    setState(() {
      _adEvent = '设置成功';
    });
    FlutterQqAds.onEventListener((event) {
      _adEvent = 'adId:${event.adId} action:${event.action}';
      if (event is AdErrorEvent) {
        // 错误事件
        _adEvent += ' errCode:${event.errCode} errMsg:${event.errMsg}';
      } else if (event is AdRewardEvent) {
        // 激励事件
        _adEvent +=
            ' transId:${event.transId} customData:${event.customData} userId:${event.userId}';
      }
      print('onEventListener:$_adEvent');
      setState(() {});
    });
  }

  /// 请求应用跟踪透明度授权
  Future<void> requestIDFA() async {
    bool result = await FlutterQqAds.requestIDFA;
    _adEvent = '请求广告标识符:$result';
    setState(() {});
  }

  /// 设置个性化广告
  /// [state] 0:不限制 1:限制
  Future<void> setPersonalizedAd(int state) async {
    bool result = await FlutterQqAds.setPersonalizedState(state);
    _adEvent = '设置个性化广告:$result';
    setState(() {});
  }

  /// 展示插屏广告
  Future<void> showInterstitialAd(
    String posId, {
    bool showFullScreenVideo = false,
    bool showRewardVideo = false,
  }) async {
    try {
      bool result = await FlutterQqAds.showInterstitialAd(
        posId,
        showPopup: false,
        showFullScreenVideo: showFullScreenVideo,
        showRewardVideo: showRewardVideo,
        autoPlayMuted: false,
        autoPlayOnWifi: false,
        userId: 'userId',
        customData: 'showInterstitialAd customData',
      );
      _result = "展示插屏广告${result ? '成功' : '失败'}";
    } on PlatformException catch (e) {
      _result = "展示插屏广告失败 code:${e.code} msg:${e.message} details:${e.details}";
    }
    setState(() {});
  }

  /// 展示激励视频广告
  Future<void> showRewardVideoAd() async {
    try {
      bool result = await FlutterQqAds.showRewardVideoAd(
        AdsConfig.rewardVideoId,
        playMuted: false,
        customData: 'showRewardVideoAd customData',
        userId: 'userId',
      );
      _result = "展示激励视频广告${result ? '成功' : '失败'}";
    } on PlatformException catch (e) {
      _result =
          "展示激励视频广告失败 code:${e.code} msg:${e.message} details:${e.details}";
    }
    setState(() {});
  }
}

/// 展示开屏广告
/// [logo] 展示如果传递则展示logo，不传递不展示
Future<void> showSplashAd([String? logo]) async {
  try {
    bool result = await FlutterQqAds.showSplashAd(
      AdsConfig.splashId,
      logo: logo,
      fetchDelay: 3,
    );
    _result = "展示开屏广告${result ? '成功' : '失败'}";
  } on PlatformException catch (e) {
    _result = "展示开屏广告失败 code:${e.code} msg:${e.message} details:${e.details}";
  }
}
