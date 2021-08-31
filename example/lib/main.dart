import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qq_ads/flutter_qq_ads.dart';
import 'ads_config.dart';

// 结果信息
String _result = '';

void main() {
  /// 绑定引擎
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _adEvent = '';

  @override
  void initState() {
    super.initState();
    init().then((value) {
      if (value) {
        showSplashAd(AdsConfig.logo);
      }
    });
    setAdEvent();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('FlutterAds QQ plugin'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                Text('Result: $_result'),
                SizedBox(height: 10),
                Text('onAdEvent: $_adEvent'),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('初始化'),
                  onPressed: () {
                    init();
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('请求应用跟踪透明度授权(仅 iOS)'),
                  onPressed: () {
                    requestIDFA();
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('展示开屏广告（Logo2）'),
                  onPressed: () {
                    showSplashAd(AdsConfig.logo2);
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('展示开屏广告（全屏）'),
                  onPressed: () {
                    showSplashAd();
                    setState(() {});
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('展示插屏广告'),
                  onPressed: () {
                    showInterstitialAd(AdsConfig.interstitialId);
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('展示插屏全屏视频广告'),
                  onPressed: () {
                    showInterstitialAd(
                      AdsConfig.interstitialFullScreenVideoId,
                      showFullScreenVideo: true,
                    );
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('展示插屏激励视频广告'),
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
                  child: Text('展示激励视频广告'),
                  onPressed: () {
                    showRewardVideoAd();
                  },
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 100,
                  child: AdBannerWidget(
                    posId: AdsConfig.bannerId,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
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
        detailPageMuted: false,
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

/// 初始化广告 SDK
Future<bool> init() async {
  try {
    bool result = await FlutterQqAds.initAd(AdsConfig.appId);
    _result = "广告SDK 初始化${result ? '成功' : '失败'}";
    return result;
  } on PlatformException catch (e) {
    _result =
        "广告SDK 初始化失败 code:${e.code} msg:${e.message} details:${e.details}";
  }
  return false;
}

/// 展示开屏广告
/// [logo] 展示如果传递则展示logo，不传递不展示
Future<void> showSplashAd([String logo]) async {
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
