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
    // 官方 demo id
    // com.qq.gdt.GDTMobSample
    // return '1105344611';
    // com.banjixiaoguanjia.app
    if (Platform.isAndroid) {
      return '1200012024';
    } else {
      return '1200018693';
    }
  }

  /// 获取开屏广告位id
  static String get splashId {
    // 官方demo
    // return "9040714184494018";
    if (Platform.isAndroid) {
      return '8022311121246224';
    } else {
      return '5052818319908354';
    }
  }

  /// 获取插屏广告位id
  static String get interstitialId {
    // 官方demo
    // return "9040714184494018";
    if (Platform.isAndroid) {
      return '3022327103988804';
    } else {
      return '5092321153081845';
    }
  }

  /// 获取插屏全屏视频广告位id
  static String get interstitialFullScreenVideoId {
    // 官方demo
    // return "9040714184494018";
    if (Platform.isAndroid) {
      return '3012521499614895';
    } else {
      return '3092322459911886';
    }
  }

  /// 获取激励视频广告位id
  static String get rewardVideoId {
    // 官方demo
    // return "9040714184494018";
    if (Platform.isAndroid) {
      return '3032129193181886';
    } else {
      return '1042528123383807';
    }
  }
}
