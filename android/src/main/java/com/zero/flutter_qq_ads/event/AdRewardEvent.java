package com.zero.flutter_qq_ads.event;

import java.util.HashMap;

/**
 * 广告激励事件
 */
public class AdRewardEvent extends AdEvent {
    // 服务端验证唯一id
    private final String transId;
    // 服务端验证的自定义信息
    private final String customData;
    // 服务端验证的用户信息
    private final String userId;

    public AdRewardEvent(String adId, String action, String transId, String customData, String userId) {
        super(adId, AdEventAction.onAdReward);
        this.transId = transId;
        this.customData = customData;
        this.userId = userId;
    }

    @Override
    public HashMap<String, Object> toMap() {
        HashMap<String, Object> newMap = super.toMap();
        newMap.put("transId", transId);
        newMap.put("customData", customData);
        newMap.put("userId", userId);
        return newMap;
    }
}
