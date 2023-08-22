import 'dart:io';

/// 广告配置信息
class AdsConfig {
  /// 获取 Logo 资源名称
  static String get logo {
    if (Platform.isAndroid) {
      return 'flutterads_logo';
    } else {
      return 'LaunchImage';
    }
  }

  /// 获取 Logo 资源名称 2
  static String get logo2 {
    if (Platform.isAndroid) {
      return 'flutterads_logo2';
    } else {
      return 'LaunchImage2';
    }
  }

  /// 获取 App id
  static String get appId {
    return Platform.isAndroid ? '1204814627' : '1204814641';
  }

  /// 获取开屏广告位id
  static String get splashId {
    return Platform.isAndroid ? '4046660274345204' : '1046662224832381';
  }

  /// 获取插屏广告位id
  static String get interstitialId {
    return Platform.isAndroid ? '1066865274941328' : '7046066294830767';
  }

  /// 获取插屏全屏视频广告位id
  static String get interstitialFullScreenVideoId {
    if (Platform.isAndroid) {
      return '3012521499614895';
    } else {
      return '3092322459911886';
    }
  }

  /// 获取插屏激励视频广告位id
  static String get interstitialRewardVideoId {
    if (Platform.isAndroid) {
      return '2052820580637311';
    } else {
      return '9022927550132316';
    }
  }

  /// 获取激励视频广告位id
  static String get rewardVideoId {
    if (Platform.isAndroid) {
      return '6086667264144219';
    } else {
      return '3066367234238599';
    }
  }

  /// 获取 Banner 广告位id
  static String get bannerId {
    if (Platform.isAndroid) {
      return '5086068204047616';
    } else {
      return '7026465284342149';
    }
  }

  /// 获取信息流广告位id
  static String get feedId {
    if (Platform.isAndroid) {
      return '7036167274246466';
    } else {
      return '8076264204347078';
    }
  }
}
