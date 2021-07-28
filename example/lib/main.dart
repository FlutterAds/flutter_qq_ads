import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_qq_ads/flutter_qq_ads.dart';

//广告id
String appId = "1200012024";
//开屏广告位id
String posIdSplash = "8022311121246224";
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
        showSplashAd('ic_logo');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
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
              SizedBox(height: 10),
              ElevatedButton(
                child: Text('添加广告监听'),
                onPressed: () {
                  setAdEvent();
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: Text('请求权限'),
                onPressed: () {
                  checkAndReqPermission();
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('展示开屏广告（Logo）'),
                onPressed: () {
                  showSplashAd('ic_logo2');
                  setState(() {});
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
            ],
          ),
        ),
      ),
    );
  }
}

/// 初始化广告 SDK
Future<bool> init() async {
  try {
    bool result = await FlutterQqAds.initAd(appId);
    _result = "广告SDK 初始化${result ? '成功' : '失败'}";
    return result;
  } on PlatformException catch (e) {
    _result =
        "广告SDK 初始化失败 code:${e.code} msg:${e.message} details:${e.details}";
  }
  return false;
}

/// 请求权限
Future<void> checkAndReqPermission() async {
  // try {
  //   bool result = await FlutterFnAdPlugin.checkAndReqPermission();
  //   _result = "广告SDK 权限请求${result ? '成功' : '失败'}";
  // } on PlatformException catch (e) {
  //   _result =
  //       "广告SDK 权限请求失败 code:${e.code} msg:${e.message} details:${e.details}";
  // }
  // setState(() {});
}

/// 设置广告监听
Future<void> setAdEvent() async {
  // setState(() {
  //   _adEvent = '设置成功';
  // });
  // FlutterQqAds.onEventListener((event) {
  //   setState(() {
  //     _adEvent = 'type:${event.eventType} msg:${event.msg}';
  //   });
  // });
}

/// 展示开屏广告
/// [logo] 展示如果传递则展示logo，不传递不展示
Future<void> showSplashAd([String logo]) async {
  try {
    bool result = await FlutterQqAds.showSplashAd(posIdSplash, logo);
    _result = "展示开屏广告${result ? '成功' : '失败'}";
  } on PlatformException catch (e) {
    _result = "展示开屏广告失败 code:${e.code} msg:${e.message} details:${e.details}";
  }
}
