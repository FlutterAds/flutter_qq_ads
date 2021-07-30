# flutter_qq_ads

<p align="center">
<img src="https://raw.githubusercontent.com/FlutterAds/site/master/logo/flutterads_logo.png" alt="logo" height="144"/>
</p>
<h3 align="center">一款优质的 Flutter 广告插件（腾讯广告、广点通、优量汇）</h3>

## 入门使用

### 引入依赖

- Pub 引入

``` Dart
正式上线稳定后发布
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
    print('onEventListener adId:${event.adId} action:${event.action}');
});
```
### 开屏广告

- 半屏广告 + Logo

``` Dart
FlutterQqAds.showSplashAd(splashId, 'ic_start_img');
```
- 全屏广告

``` Dart
FlutterQqAds.showSplashAd(splashId);
```

- [Logo 设置的最佳实践（待补充）]()


## 遇到问题
如果你遇到问题请提 Issues 给我（提问前建议先搜索尝试，没有再提问）

## 支持我

支持开源项目最好的方式就是点一个 Star
