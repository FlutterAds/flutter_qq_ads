<p align="center">
<a href="https://github.com/FlutterAds"><img src="https://raw.githubusercontent.com/FlutterAds/site/master/logo/flutterads_logo.png" alt="logo" height="144"/></a>
</p>
<h3 align="center">一款优质的 Flutter 广告插件（腾讯广告、广点通、优量汇）</h3>

<p align="center">
<a href="https://github.com/FlutterAds/flutter_qq_ads"><img src=https://img.shields.io/badge/pub-v2.7.0-success></a>
<a href="https://github.com/FlutterAds/flutter_qq_ads"><img src=https://img.shields.io/badge/platform-iOS%20%7C%20Android-brightgreen></a>
<a href="https://github.com/FlutterAds/flutter_qq_ads/actions/workflows/flutter.yml"><img src="https://github.com/FlutterAds/flutter_qq_ads/actions/workflows/flutter.yml/badge.svg"></a>
<a href="https://github.com/FlutterAds/flutter_qq_ads"><img src=https://img.shields.io/github/stars/FlutterAds/flutter_qq_ads?color=brightgreen></a>
<a href="https://github.com/FlutterAds/flutter_qq_ads/blob/develop/LICENSE"><img src=https://img.shields.io/badge/license-MIT-brightgreen></a>
</p>

## 插件特点
- 🔨 接入简单快速（封装原生端配置，仅需引入即可）
- 📡 事件统一返回（将原生端各种重要回调事件统一返回，方便业务处理和埋点统计等需求）
- 🎁 注重优化体验（无闪烁 Logo 开屏、权限申请、隐私跟踪申请等、信息流自动适配宽高）
- 🏆 极客代码封装（原生端代码不凑合，两端统一基础框架、广告事件封装抽象、易扩展新广告形式、方便开发个性化需求）

## 支持功能
- ✅ [开屏广告](#开屏广告)
- ✅ [插屏广告](#插屏广告)
  - ✅ 半插屏
  - ✅ 全屏视频
  - ✅ 激励视频
- ✅ [激励视频](#激励视频)
- ✅ [Banner](#Banner)
- ✅ [信息流](#信息流)

## 📣 推荐使用 GroMore

- 【[Gromore](https://flutterads.github.io/site/)】可进行多家广告瀑布流竞价，让您拥有更高的广告收益，发挥最大的用户价值

[![](https://raw.githubusercontent.com/FlutterAds/.github/main/gromore_pro_site.png)](https://flutterads.github.io/site/)

## 下载体验
<a href="https://www.pgyer.com/app/qrcode/fadsqq"><img src="https://raw.githubusercontent.com/yy1300326388/yy1300326388/main/images/gzh/gzh_qrcode.jpeg" width='100' height='100'></a>
> 回复 `优量汇体验` 

## 入门使用
### 引入依赖

``` Dart
dependencies:
  flutter_qq_ads: ^2.7.0
```

### 初始化广告

``` Dart
/// [appId] 应用媒体ID
FlutterQqAds.initAd(appId);
```
### 开屏广告

- 半屏广告 + Logo

``` Dart
/// [posId] 广告位 id
/// [logo] 如果传值则展示底部logo，不传不展示，则全屏展示
/// [fetchDelay] 拉取广告的超时时间，默认值 3 秒，取值范围[1.5~5]秒
FlutterQqAds.showSplashAd(
    AdsConfig.splashId,
    logo: 'flutterads_logo',
    fetchDelay: 3,
  );
```
- [Logo 设置的最佳实践（必看）](https://github.com/FlutterAds/flutter_qq_ads/blob/develop/doc/SETTING_LOGO.md)

- 全屏广告

``` Dart
FlutterQqAds.showSplashAd(posId);
```
### 插屏广告
- 插屏半屏
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
- 插屏全屏视频
``` Dart
/// [posId] 广告位 id
/// [showFullScreenVideo] 插屏全屏视频形式显示
FlutterQqAds.showInterstitialAd(
    posId,
    showFullScreenVideo: true,
  );
```

- 插屏激励视频
``` Dart
/// [posId] 广告位 id
/// [showRewardVideo] 插屏激励视频形式显示
/// [customData] 设置服务端验证的自定义信息
/// [userId] 设置服务端验证的用户信息
FlutterQqAds.showInterstitialAd(
    posId,
    showRewardVideo: true,
    customData: 'customData',
    userId: 'userId',
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

### Banner
``` Dart
/// [posId] 广告位 id
/// [width] 宽度
/// [height] 高度
/// [interval] 广告刷新间隔，0 或[30~120]之间的数字，单位为 s,默认 30s 
///  Android:0 表示不自动轮播 
///  iOS:0 表示关闭轮播动画，因为 iOS 没有不轮播
/// [show] 是否显示广告
AdBannerWidget(
  posId: AdsConfig.bannerId02,
  width: 375,
  height: 100, 
  interval: 120, 
  show: true,
)
```
> `v1.4.0` 开始不再需要外部嵌套，如果需要按比例设置，可以看如下示例：

- 嵌套宽高比约束布局 `AspectRatio`

``` Dart
AspectRatio(
  aspectRatio: 6.4 / 1, // 6.4:1 的比例
  child: AdBannerWidget(
    posId: AdsConfig.bannerId02,
    width: double.maxFinite,
    height: double.maxFinite,
    interval: 120,
  ),
),
```

### 信息流
- 获取信息流广告列表
``` Dart
/// [posId] 广告位 id
/// [width] 宽度
/// [height] 高度，0：代表自适应广告高度
/// [count] 获取广告数量，建议 1~3 个
List<int> feedAdList = await FlutterQqAds.loadFeedAd(
    AdsConfig.feedId,
    width: 375,
    height: 0,
    count: 3,
  );
```
- 清除信息流广告列表

> 当你的广告不再需要时，请一定执行清除操作
``` Dart
/// [list] 信息流广告 id 列表
bool result = await FlutterQqAds.clearFeedAd(feedAdList);
```
- 页面中展示信息流广告

``` Dart
/// Feed 信息流广告组件
/// [posId]返回的广告 id，这里不是广告位id
/// [width]组件的宽度
/// [height]组件的高度
/// [show]是否显示
AdFeedWidget(
    posId: '${feedAdList[0]}',
    width: 375,
    height: 128,
    show: true,
  )
```

> `width` 和 `height` 只是展示 widget 组件宽高，最终会自动适配实际广告的宽高，不可设置为 0

### 设置广告事件监听

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
### 事件列表
|事件|说明|
|-|-|
|onAdLoaded|广告加载成功|
|onAdPresent|广告填充|
|onAdExposure|广告曝光|
|onAdClosed|广告关闭（开屏计时结束或者用户点击关闭）|
|onAdClicked|广告点击|
|onAdSkip|广告跳过|
|onAdComplete|广告播放或计时完毕|
|onAdError|广告错误|
|onAdReward|获得广告激励|

> 这里做了统一的抽象，iOS 和 Android 原生 SDK 名称不同，如果觉得对应不上，可以提 [Issues](https://github.com/FlutterAds/flutter_qq_ads/issues)（一定要加上 log 截图）
## 其他配置
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

## 原生 SDK 版本更新方法
如果是大版本，我会第一时间适配更新，小版本可以自己更新，方法如下：
- Android

  方法1：可以给我提 Issues 提示我更新，版本号 `x.y.z`，会更新 `z` 版本迭代
  
  方法2：可以自己指定版本，方法如下:
```shell
// build.gradle(android.app)
android{
  configurations.all {
      resolutionStrategy {
          force 'com.qq.e.union:union:版本号'
      }
  }
}
```
- iOS

  自己手动更新，自己的项目根目录下执行即可
```shell
// 可在 ios/Podfile.lock 中查看 SDK 当前版本
cd ios
rm -rf Podfile.lock
pod repo update
pod install
```

## 分支说明
|分支|说明|
|-|-|
|develop|开发分支，接受 PR|
|master|稳定分支，空安全|
|1x|已不更新，非空安全|

## 更新日志
[查看 Releases 版本日志](https://github.com/FlutterAds/flutter_qq_ads/releases)

## 遇到问题
如果你遇到问题请提 [Issues](https://github.com/FlutterAds/flutter_qq_ads/issues) 给我（提问前建议先搜索尝试，没有再提问）

## 支持开源

- 开源不易，需要花费大量休息时间加班熬夜来维护，你可以通过下方二维码赞赏支持我。

<a href="https://raw.githubusercontent.com/yy1300326388/yy1300326388/main/images/pay_qr_code/pay_qr_code.png">
    <img width="300" alt="coffee" src="https://raw.githubusercontent.com/yy1300326388/yy1300326388/main/images/pay_qr_code/pay_qr_code.png">
</a>

- 用爱发电，给本项目点个免费的 [Star](https://github.com/FlutterAds/flutter_qq_ads) ⭐️ 也是非常好的支持。


## FlutterAds 广告插件系列
|插件|描述|
|-|-|
|[flutter_gromore_pro](https://flutterads.github.io/site/)|🏆🏆🏆 帮你大幅提升广告收益，发挥出最大的用户价值|
|[flutter_gromore_ads](https://github.com/FlutterAds/flutter_gromore_ads)|字节跳动、穿山甲、GroMore 聚合 Flutter 广告开源版插件|
|[flutter_pangle_ads](https://github.com/FlutterAds/flutter_pangle_ads)|字节跳动、穿山甲 Flutter 广告插件|
|[flutter_qq_ads](https://github.com/FlutterAds/flutter_qq_ads)|腾讯广告、广点通、优量汇 Flutter 广告插件|
|[flutter_adspark](https://github.com/FlutterAds/flutter_adspark)|巨量广告/穿山甲的广告监测、增长分析、归因上报、事件管理 Flutter 版插件|

## 💬 App 广告变现群

- 插件问题解答
- 变现玩法交流
- 收益提升探讨
- 大盘趋势推送
- 版本更新推送

> 因微信群入群限制，请添加个人微信备注：`变现群`，我拉你进群。

<img src="https://flutterads.github.io/site/wechat.webp" alt="wechat:toponelan" width="160"/>
