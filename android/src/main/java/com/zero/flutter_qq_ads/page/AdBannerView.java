package com.zero.flutter_qq_ads.page;

import android.app.Activity;
import android.content.Context;
import android.util.Log;
import android.view.View;
import android.widget.FrameLayout;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.qq.e.ads.banner2.UnifiedBannerADListener;
import com.qq.e.ads.banner2.UnifiedBannerView;
import com.qq.e.comm.util.AdError;
import com.zero.flutter_qq_ads.PluginDelegate;
import com.zero.flutter_qq_ads.event.AdEventAction;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.platform.PlatformView;

import java.util.Locale;
import java.util.Map;

/**
 * Banner 广告 View
 */
class AdBannerView extends BaseAdPage implements PlatformView, UnifiedBannerADListener {
    private final String TAG = AdBannerView.class.getSimpleName();
    @NonNull
    private final FrameLayout frameLayout;
    private final PluginDelegate pluginDelegate;
    private int id;
    private UnifiedBannerView bv;
    private Map<String, Object> params;


    AdBannerView(@NonNull Context context, int id, @Nullable Map<String, Object> creationParams, PluginDelegate pluginDelegate) {
        this.id = id;
        this.pluginDelegate = pluginDelegate;
        this.params = creationParams;
        frameLayout = new FrameLayout(context);
        MethodCall call = new MethodCall("AdBannerView", creationParams);
        showAd(this.pluginDelegate.activity,call);
    }

    @NonNull
    @Override
    public View getView() {
        return frameLayout;
    }

    @Override
    public void dispose() {
        disposeAd();
    }

    @Override
    public void loadAd( @NonNull MethodCall call) {
        // 获取轮播时间间隔参数
        int interval= (int) this.params.get("interval");
        // 加载广告 Banner
        bv = new UnifiedBannerView(activity, posId, this);
        frameLayout.addView(bv);
        // 设置轮播时间间隔
        bv.setRefresh(interval);
        bv.loadAD();
    }

    /**
     * 销毁广告
     */
    private void disposeAd(){
        frameLayout.removeAllViews();
        if (bv != null) {
            bv.destroy();
        }
    }

    @Override
    public void onNoAD(AdError error) {
        String msg = String.format(Locale.getDefault(), "onNoAD, error code: %d, error msg: %s",
                error.getErrorCode(), error.getErrorMsg());
        Log.e(TAG, msg);
        sendErrorEvent(error.getErrorCode(), error.getErrorMsg());
        disposeAd();
    }

    @Override
    public void onADReceive() {
        Log.i(TAG, "onADReceive");
        sendEvent(AdEventAction.onAdLoaded);
    }

    @Override
    public void onADExposure() {
        Log.i(TAG, "onADExposure");
        sendEvent(AdEventAction.onAdExposure);
    }

    @Override
    public void onADClosed() {
        Log.i(TAG, "onADClosed");
        sendEvent(AdEventAction.onAdClosed);
        disposeAd();
    }

    @Override
    public void onADClicked() {
        Log.i(TAG, "onADClicked");
        sendEvent(AdEventAction.onAdClicked);
    }

    @Override
    public void onADLeftApplication() {
        Log.i(TAG, "onADLeftApplication");
    }

    @Override
    public void onADOpenOverlay() {
        Log.i(TAG, "onADOpenOverlay");
//        sendEvent(AdEventAction.onAdClicked);
    }

    @Override
    public void onADCloseOverlay() {
        Log.i(TAG, "onADCloseOverlay");
//        sendEvent(AdEventAction.onAdClosed);
    }


}