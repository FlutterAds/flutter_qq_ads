package com.zero.flutter_qq_ads.event;

import java.util.HashMap;

/**
 *  广告错误事件
 */
public class AdErrorEvent extends AdEvent {
    // 错误码
    int errCode;
    // 错误信息
    String errMsg;
    // 错误事件实体
    public AdErrorEvent(String adId, String action, int errCode, String errMsg) {
        super(adId, action);
        this.errCode = errCode;
        this.errMsg = errMsg;
    }

    /**
     * 重写 toMap 方法
     * @return 返回错误事件的map
     */
    @Override
    public HashMap<String, Object> toMap() {
        HashMap<String, Object> newMap= super.toMap();
        newMap.put("errCode",errCode);
        newMap.put("errMsg",errMsg);
        return newMap;
    }
}
