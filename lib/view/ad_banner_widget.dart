import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Banner 广告组件
class AdBannerWidget extends StatefulWidget {
  AdBannerWidget({
    Key key,
    @required this.posId,
    this.interval = 30,
    this.show = true,
    this.width = 300,
    this.height = 150,
  }) : super(key: key);
  // 广告 id
  final String posId;
  // 广告刷新间隔，0 或[30~120]之间的数字，单位为 s,默认 30s
  // Android:0 表示不自动轮播
  // iOS:0 表示关闭轮播动画，因为 iOS 没有不轮播
  final int interval;
  // 宽高
  final double width, height;
  // 是否显示广告
  final bool show;

  @override
  _AdBannerWidgetState createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  // View 类型
  final String viewType = 'flutter_qq_ads_banner';
  // 创建参数
  Map<String, dynamic> creationParams;

  @override
  void initState() {
    creationParams = <String, dynamic>{
      "posId": widget.posId,
      "interval": widget.interval
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.show) {
      return SizedBox.shrink();
    }
    Widget view;
    if (Platform.isIOS) {
      view = UiKitView(
        viewType: viewType,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else {
      view = AndroidView(
        viewType: viewType,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
    return SizedBox.fromSize(
      size: Size(widget.width, widget.height),
      child: view,
    );
  }
}
