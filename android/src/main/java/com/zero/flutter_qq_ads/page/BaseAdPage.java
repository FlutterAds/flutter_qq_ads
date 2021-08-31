package com.zero.flutter_qq_ads.page;

import android.app.Activity;

import com.zero.flutter_qq_ads.event.AdErrorEvent;
import com.zero.flutter_qq_ads.event.AdEvent;
import com.zero.flutter_qq_ads.event.AdEventHandler;

import io.flutter.plugin.common.MethodCall;

/**
 * 基础广告页面
 */
public abstract class BaseAdPage {
    // 上下文
    protected Activity activity;
    // 广告位 id
    protected String posId;


    /**
     * 显示广告
     *
     * @param activity 上下文
     * @param posId    广告位 id
     * @param call     方法调用
     */
    public void showAd(Activity activity, String posId, MethodCall call) {
        this.activity = activity;
        this.posId = posId;
        loadAd(activity, call);
    }

    /**
     * 加载广告
     *
     * @param activity 上下文
     * @param call     方法调用
     */
    public abstract void loadAd(Activity activity, MethodCall call);


    /**
     * 发送广告事件
     *
     * @param event 广告事件
     */
    protected void sendEvent(AdEvent event) {
        AdEventHandler.getInstance().sendEvent(event);
    }

    /**
     * 发送广告事件
     *
     * @param action 操作
     */
    protected void sendEvent(String action) {
        sendEvent(new AdEvent(posId, action));
    }

    /**
     * 发送错误事件
     *
     * @param errCode 错误码
     * @param errMsg  错误事件
     */
    protected void sendErrorEvent(int errCode, String errMsg) {
        sendEvent(new AdErrorEvent(posId, errCode, errMsg));
    }
}
