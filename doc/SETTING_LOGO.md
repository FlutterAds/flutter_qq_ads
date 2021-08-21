## 半开屏广告设置 Logo 最佳实践
本页主要聊聊半开屏广告的 Logo 设置计算规则，帮助你设计一个良好体验的开屏（支持开源项目的最好方式就是点个 Star）
### 预览效果
|iOS|Android|
|:--:|:--:|
|![](https://raw.githubusercontent.com/FlutterAds/site/master/docs/images/04_iOS_splash.gif)|![](https://github.com/FlutterAds/site/blob/master/docs/images/07_Android_splash.gif?raw=true)|

通过上面的预览图可以看出，底部 Logo 在启动页和广告页非常自然的过渡，仿佛就在同一个页面，下面我们看看怎么配置。
### 曝光规则
看了各大平台的半开屏广告的其中一个曝光要求是占屏比不低于 `75%`，我们为了保证曝光，让 Logo 的占屏比为 `15%` 左右。

> 如果你有需求改为动态的需求，可以提 issues

### iOS
默认我们按照高度 `750` 进行计算，，不进行动态适配，至于全面屏是自然就适配的。
- 计算公式
```
Logo 区域高度 = 750*15%=112.5
Logo 的高度@1x = 90
Logo 距离底部高度 = (112.5-90)/2=11.25
```
- 配置启动 Logo

首先这里的「FlutterAds」启动页 Logo 高度是 `90`，你的 Logo 是多少就自己套入公式计算，不要超过 `112.5`

![Logo 高度](https://raw.githubusercontent.com/FlutterAds/site/master/docs/images/05_iOS_launchimage.png)

然后配置 `LaunchScreen.storyboard`，设置约束距离底部值为 `-11.25`

![配置启动页面](https://raw.githubusercontent.com/FlutterAds/site/master/docs/images/06_iOS_LaunchScreen.png)

- 调用半开屏广告接口
```Dart
FlutterQqAds.showSplashAd(posId, 'LaunchImage');
```

### Android

默认我们按照高度 `1920` 进行计算的，算下来是 `96dp`，不进行动态适配

- 计算公式

```
Logo 区域高度 = 1920*15%=288=96dp
Logo 的高度 = 180/3=60dp
Logo 距离底部高度 = (96-60)/2=18dp
```
- 配置启动页 Logo

这里启动 Logo 的高度是 `180`

![Logo 高度](https://raw.githubusercontent.com/FlutterAds/site/master/docs/images/07_Android_LaunchImage.png)

然后我们根据计算公式配置启动页背景

![启动页背景](https://github.com/FlutterAds/site/blob/master/docs/images/08_Android_LauncPage.png?raw=true)

下面对应代码可以复制修改

```xml
<?xml version="1.0" encoding="utf-8"?><!-- Modify this file to customize your launch splash screen -->
<layer-list xmlns:android="http://schemas.android.com/apk/res/android">
    <!--白色背景-->
    <item android:drawable="@android:color/white" />
    <!--底部 Logo-->
    <item android:bottom="18dp">
        <bitmap
            android:gravity="bottom"
            android:src="@mipmap/flutterads_logo" />
    </item>
</layer-list>

```
修改 `style`

![style](https://github.com/FlutterAds/site/blob/master/docs/images/09_Android_style.png?raw=true)

设置启动样式

![启动样式](https://github.com/FlutterAds/site/blob/master/docs/images/10_Android_launch_theme.png?raw=true)

- 调用半开屏广告接口
```Dart
FlutterQqAds.showSplashAd(posId, 'flutterads_logo');
```
> 这里的启动图页 Logo 要放到 `mipmap` 下，放到 `drawable` 下广告页无法找到

### 遇到问题

如果你遇到问题请提 Issues 给我（提问前建议先搜索尝试，没有再提问）

### 支持开源

支持开源项目最好的方式就是点一个 Star

