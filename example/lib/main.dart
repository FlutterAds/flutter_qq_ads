import 'package:flutter/material.dart';
import 'package:flutter_qq_ads/flutter_qq_ads.dart';

import 'ads_config.dart';
import 'pages/home_page.dart';

void main() {
  // 绑定引擎
  WidgetsFlutterBinding.ensureInitialized();
  setAdEvent();
  init().then((value) {
    if (value) {
      FlutterQqAds.showSplashAd(
        AdsConfig.splashId,
        logo: AdsConfig.logo,
      );
    }
  });

  // 启动
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

/// 初始化广告 SDK
Future<bool> init() async {
  bool result = await FlutterQqAds.initAd(AdsConfig.appId);
  debugPrint("广告SDK 初始化${result ? '成功' : '失败'}");
  return result;
}

/// 设置广告监听
Future<void> setAdEvent() async {
  FlutterQqAds.onEventListener((event) {
    debugPrint('adId:${event.adId} action:${event.action}');
    if (event is AdErrorEvent) {
      // 错误事件
      debugPrint(' errCode:${event.errCode} errMsg:${event.errMsg}');
    } else if (event is AdRewardEvent) {
      // 激励事件
      debugPrint(
          ' transId:${event.transId} userId:${event.userId} customData:${event.customData}');
    }
  });
}
