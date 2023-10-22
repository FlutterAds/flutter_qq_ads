import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_qq_ads/flutter_qq_ads.dart';
import '../router/router.dart';
import '../theme/style.dart';
import 'banner_page.dart';
import 'feed_page.dart';

import 'interstitial_page.dart';
import 'reward_video_page.dart';
import 'splash_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                InkWell(
                  child: Image.asset(
                    'images/gromore_pro.png',
                    width: double.maxFinite,
                  ),
                  onTap: () => pushProPage(context),
                ),
                kDivider,
                ListTile(
                  dense: true,
                  title: Text('请求应用跟踪透明授权(iOS)'),
                  onTap: () => requestIDFA(),
                ),
                kDivider,
                ListTile(
                  dense: true,
                  title: Text('设置个性化广告'),
                  onTap: () => setPersonalizedAd(1),
                ),
                kDivider,
                ListTile(
                  title: Text('开屏广告'),
                  onTap: () => pushPage(context, SplashPage()),
                ),
                kDivider,
                ListTile(
                  title: Text('新插屏广告'),
                  onTap: () => pushPage(context, InterstitialPage()),
                ),
                kDivider,
                ListTile(
                  title: Text('Banner 广告'),
                  onTap: () => pushPage(context, BannerPage()),
                ),
                kDivider,
                ListTile(
                  title: Text('激励视频广告'),
                  onTap: () => pushPage(context, RewardVideoPage()),
                ),
                kDivider,
                ListTile(
                  title: Text('信息流'),
                  onTap: () => pushPage(context, FeedPage()),
                ),
                kDivider,
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 请求应用跟踪透明度授权
  Future<void> requestIDFA() async {
    bool result = await FlutterQqAds.requestIDFA;
    print('请求广告标识符:$result');
  }

  /// 设置个性化广告
  /// [state] 0:不限制 1:限制
  Future<void> setPersonalizedAd(int state) async {
    bool result = await FlutterQqAds.setPersonalizedState(state);
    print('设置个性化广告:$result');
  }
}
