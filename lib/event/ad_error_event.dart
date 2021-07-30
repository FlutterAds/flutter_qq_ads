import 'ad_event.dart';

class AdErrorEvent extends AdEvent {
  AdErrorEvent({this.errCode, this.errMsg, String adId, String action})
      : super(adId: adId, action: action);
  // 错误码
  final int errCode;
  // 错误信息
  final String errMsg;
  // 解析 json 为错误事件对象
  factory AdErrorEvent.fromJson(Map<dynamic, dynamic> json) {
    return AdErrorEvent(
      errCode: json['errCode'],
      errMsg: json['errMsg'],
      adId: json['adId'],
      action: json['action'],
    );
  }
}
