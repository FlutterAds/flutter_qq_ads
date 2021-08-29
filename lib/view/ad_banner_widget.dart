import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Banner 广告组件
class AdBannerWidget extends StatefulWidget {
  AdBannerWidget({Key key, this.posId}) : super(key: key);
  // 广告 id
  final String posId;

  @override
  _AdBannerWidgetState createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  final String viewType = 'flutter_qq_ads_banner';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> creationParams = <String, dynamic>{
      "posId": widget.posId
    };
    if (Platform.isIOS) {
      return UiKitView(
        viewType: viewType,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else {
      return AndroidView(
        viewType: viewType,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
  }
}
