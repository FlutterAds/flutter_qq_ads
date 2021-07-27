
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterQqAds {
  static const MethodChannel _channel =
      const MethodChannel('flutter_qq_ads');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
