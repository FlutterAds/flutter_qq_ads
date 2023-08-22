package com.zero.flutter_qq_ads.load;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.localbroadcastmanager.content.LocalBroadcastManager;

import com.qq.e.ads.nativ.ADSize;
import com.qq.e.ads.nativ.NativeExpressAD;
import com.qq.e.ads.nativ.NativeExpressADView;
import com.qq.e.comm.util.AdError;
import com.zero.flutter_qq_ads.PluginDelegate;
import com.zero.flutter_qq_ads.event.AdEventAction;
import com.zero.flutter_qq_ads.page.BaseAdPage;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * 信息流加载对象
 */
public class FeedAdLoad extends BaseAdPage implements NativeExpressAD.NativeExpressADListener {
    private final String TAG = FeedAdLoad.class.getSimpleName();
    private MethodChannel.Result result;

    /**
     * 加载信息流广告列表
     *
     * @param call
     * @param result
     */
    public void loadFeedAdList(Activity activity, @NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        this.result = result;
        showAd(activity, call);
    }

    @Override
    public void loadAd(@NonNull MethodCall call) {
        // 获取请求模板广告素材的尺寸
        int width = call.argument("width");
        int height = call.argument("height");
        int count = call.argument("count");
        NativeExpressAD ad = new NativeExpressAD(activity, new ADSize(width, height), this.posId, this);
        ad.loadAD(count);
    }

    @Override
    public void onADLoaded(List<NativeExpressADView> list) {
        Log.i(TAG, "onADLoaded");
        List<Integer> adResultList = new ArrayList<>();
        if (list == null || list.size() == 0) {
            this.result.success(adResultList);
            return;
        }
        for (NativeExpressADView adItem : list) {
            int key = adItem.hashCode();
            adResultList.add(key);
            FeedAdManager.getInstance().putAd(key, adItem);
        }
        // 添加广告事件
        sendEvent(AdEventAction.onAdLoaded);
        this.result.success(adResultList);
    }

    @Override
    public void onRenderFail(NativeExpressADView nativeExpressADView) {
        Log.i(TAG, "onRenderFail");
        sendErrorEvent(-100, "onRenderFail");
        sendBroadcastEvent(nativeExpressADView, AdEventAction.onAdError);
    }

    @Override
    public void onRenderSuccess(NativeExpressADView nativeExpressADView) {
        Log.i(TAG, "onRenderSuccess");
        sendEvent(AdEventAction.onAdPresent);
        sendBroadcastEvent(nativeExpressADView, AdEventAction.onAdPresent);
    }

    @Override
    public void onADExposure(NativeExpressADView nativeExpressADView) {
        Log.i(TAG, "onADExposure");
        sendEvent(AdEventAction.onAdExposure);
    }

    @Override
    public void onADClicked(NativeExpressADView nativeExpressADView) {
        Log.i(TAG, "onADClicked");
        sendEvent(AdEventAction.onAdClicked);
    }

    @Override
    public void onADClosed(NativeExpressADView nativeExpressADView) {
        Log.i(TAG, "onADClosed");
        sendEvent(AdEventAction.onAdClosed);
        sendBroadcastEvent(nativeExpressADView, AdEventAction.onAdClosed);
    }

    private void sendBroadcastEvent(NativeExpressADView adView, String event) {
        Intent intent = new Intent();
        intent.setAction(PluginDelegate.KEY_FEED_VIEW + "_" + adView.hashCode());
        intent.putExtra("event", event);
        boolean result = LocalBroadcastManager.getInstance(activity).sendBroadcast(intent);
    }

    @Override
    public void onADLeftApplication(NativeExpressADView nativeExpressADView) {

    }

    @Override
    public void onNoAD(AdError error) {
        String msg = String.format(Locale.getDefault(), "onError, error code: %d, error msg: %s",
                error.getErrorCode(), error.getErrorMsg());
        Log.i(TAG, "onError, adError=" + msg);
        sendErrorEvent(error.getErrorCode(), error.getErrorMsg());
        this.result.success(new ArrayList<Integer>());
    }
}
