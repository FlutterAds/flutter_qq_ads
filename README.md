# flutter_qq_ads

<p align="center">
<img src="https://raw.githubusercontent.com/FlutterAds/site/master/logo/flutterads_logo.png" alt="logo" height="144"/>
</p>
<h3 align="center">一款优质的 Flutter 广告插件（腾讯广告、广点通、优量汇）</h3>

<p align="center">
<a href="https://github.com/FlutterAds/flutter_qq_ads"><img src=https://img.shields.io/badge/version-v1.0.0-success></a>
<a href="https://github.com/FlutterAds/flutter_qq_ads"><img src=https://img.shields.io/badge/platform-iOS%20%7C%20Android-brightgreen></a>
<a href="https://github.com/FlutterAds/flutter_qq_ads"><img src=https://img.shields.io/github/stars/FlutterAds/flutter_qq_ads?color=brightgreen></a>
<a href="https://github.com/FlutterAds/flutter_qq_ads/blob/develop/LICENSE"><img src=https://img.shields.io/badge/license-MIT-brightgreen></a>
</p>

## 入门使用

### 引入依赖

- Pub 引入

``` Dart
dependencies:
  flutter_qq_ads: ^1.0.0
```

- Git 引入

``` Dart
flutter_qq_ads:
  git: 
    url: git@github.com:FlutterAds/flutter_qq_ads.git
    ref: master
```

- 克隆后本地引入

``` Dart
flutter_qq_ads:
  path: [与主项目的相对路径 | 插件的绝对路径]
```

### 初始化广告

``` Dart
FlutterQqAds.initAd(appId);
```
### 设置广告状态监听

``` Dart
FlutterQqAds.onEventListener((event) {
  // 普通广告事件
  String _adEvent = 'adId:${event.adId} action:${event.action}';
  if (event is AdErrorEvent) {
    // 错误事件
    _adEvent += ' errCode:${event.errCode} errMsg:${event.errMsg}';
  } else if (event is AdRewardEvent) {
    // 激励事件
    _adEvent +=
        ' transId:${event.transId} customData:${event.customData} userId:${event.userId}';
  }
  print('onEventListener:$_adEvent');
});
```
### 开屏广告

- 半屏广告 + Logo

``` Dart
/// [posId] 广告位 id
/// [logo] 展示如果传递则展示底部logo，不传递不展示，则全屏
FlutterQqAds.showSplashAd(posId, 'flutterads_logo');
```
- [Logo 设置的最佳实践（待补充）](https://github.com/FlutterAds/flutter_qq_ads/blob/develop/docs/SETTING_LOGO.md)

- 全屏广告

``` Dart
FlutterQqAds.showSplashAd(posId);
```
### 插屏广告
``` Dart
/// [posId] 广告位 id
/// [showPopup] Popup 形式显示（仅 Android）
/// [autoPlayOnWifi] 是否仅在 WiFi 网络下自动播放
/// [autoPlayMuted] 自动播放是否静音
/// [detailPageMuted] 详情页是否静音
FlutterQqAds.showInterstitialAd(
    posId,
    showPopup: false,
    autoPlayMuted: false,
    autoPlayOnWifi: false,
    detailPageMuted: false,
  );
```

### 激励视频
``` Dart
/// [posId] 广告位 id
/// [playMuted] 是否静音播放
/// [customData] 设置服务端验证的自定义信息
/// [userId] 设置服务端验证的用户信息
FlutterQqAds.showRewardVideoAd(
    posId,
    playMuted: false,
    customData: 'customData',
    userId: 'userId',
  );
```

### 其他配置
### 信任HTTP请求
苹果公司在iOS9中升级了应用网络通信安全策略，默认推荐开发者使用HTTPS协议来进行网络通信，并限制HTTP协议的请求。为了避免出现无法拉取到广告的情况，我们推荐开发者在info.plist文件中增加如下配置来实现广告的网络访问
- 修改 `info.plist`
``` xml
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <true/>
</dict>
```
![信任HTTP请求](https://raw.githubusercontent.com/FlutterAds/site/master/docs/images/02_AppTransportSecurity.png)

### 请求应用跟踪透明度授权
此步骤必须要做，不然上架审核时候会被拒绝
``` Dart
bool result = await FlutterQqAds.requestIDFA;
```
- 修改 `info.plist`
``` xml
<key>NSUserTrackingUsageDescription</key>
<string>为了向您提供更优质、安全的个性化服务及内容，需要您允许使用相关权限</string>
```
![请求应用跟踪透明度授权](https://raw.githubusercontent.com/FlutterAds/site/master/docs/images/01_TrackingUsageDescription.png)

- 效果

![预览效果](https://raw.githubusercontent.com/FlutterAds/site/master/docs/images/03_RequestTracking.png)

- [官方参考链接 - 用户隐私和数据使用](https://developer.apple.com/cn/app-store/user-privacy-and-data-use/)


## 遇到问题
如果你遇到问题请提 [Issues](https://github.com/FlutterAds/flutter_qq_ads/issues) 给我（提问前建议先搜索尝试，没有再提问）

## 支持我

支持开源项目最好的方式就是点一个 [Star](https://github.com/FlutterAds/flutter_qq_ads)
