package com.zero.flutter_qq_ads.page;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.localbroadcastmanager.content.LocalBroadcastManager;

import com.qq.e.ads.nativ.NativeExpressADView;
import com.zero.flutter_qq_ads.PluginDelegate;
import com.zero.flutter_qq_ads.event.AdEventAction;
import com.zero.flutter_qq_ads.load.FeedAdManager;
import com.zero.flutter_qq_ads.utils.UIUtils;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

/**
 * Feed 信息流广告 View
 */
class AdFeedView extends BaseAdPage implements PlatformView, View.OnLayoutChangeListener {
    private final String TAG = AdFeedView.class.getSimpleName();
    @NonNull
    private final FrameLayout frameLayout;
    private final PluginDelegate pluginDelegate;
    private int id;
    private NativeExpressADView fad;
    private MethodChannel methodChannel;
    private BroadcastReceiver receiver;


    AdFeedView(@NonNull Context context, int id, @Nullable Map<String, Object> creationParams, PluginDelegate pluginDelegate) {
        this.id = id;
        this.pluginDelegate = pluginDelegate;
        methodChannel = new MethodChannel(this.pluginDelegate.bind.getBinaryMessenger(), PluginDelegate.KEY_FEED_VIEW + "/" + id);
        frameLayout = new FrameLayout(context);
        FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        frameLayout.setLayoutParams(params);
        frameLayout.addOnLayoutChangeListener(this);
        MethodCall call = new MethodCall("AdFeedView", creationParams);
        showAd(this.pluginDelegate.activity, call);
    }

    @NonNull
    @Override
    public View getView() {
        return frameLayout;
    }

    @Override
    public void dispose() {
        removeAd();
    }

    @Override
    public void loadAd(@NonNull MethodCall call) {
        int key = Integer.parseInt(this.posId);
        regReceiver(key);
        fad = FeedAdManager.getInstance().getAd(key);
        if (fad != null) {
            View adView = fad.getRootView();
            if (adView.getParent() != null) {
                ((ViewGroup) adView.getParent()).removeAllViews();
            }
            frameLayout.addView(adView);
            fad.render();
        }
    }

    /**
     * 注册广播
     *
     * @param key key
     */
    private void regReceiver(int key) {
        // 注册广播
        receiver = new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                String event = intent.getStringExtra("event");
                if (AdEventAction.onAdClosed.equals(event)||AdEventAction.onAdError.equals(event)) {
                    AdFeedView.this.disposeAd();
                }
            }
        };
        IntentFilter intentFilter = new IntentFilter(PluginDelegate.KEY_FEED_VIEW + "_" + key);
        LocalBroadcastManager.getInstance(activity).registerReceiver(receiver, intentFilter);
    }

    /**
     * 移除广告
     */
    private void removeAd() {
        frameLayout.removeAllViews();
        // 注销广播
        if (receiver != null) {
            LocalBroadcastManager.getInstance(activity).unregisterReceiver(receiver);
        }
    }

    /**
     * 销毁广告
     */
    private void disposeAd() {
        removeAd();
        FeedAdManager.getInstance().removeAd(Integer.parseInt(this.posId));
        if (fad != null) {
            fad.destroy();
        }
        // 更新宽高
        setFlutterViewSize(0f, 0f);
    }

    /**
     * 设置 FlutterAds 视图宽高
     *
     * @param width  宽度
     * @param height 高度
     */
    private void setFlutterViewSize(float width, float height) {
        int widthPd = UIUtils.px2dip(activity, width);
        int heightPd = UIUtils.px2dip(activity, height);
        Log.i(TAG, "onLayoutChange widthPd:" + widthPd + " heightPd:" + heightPd);
        // 更新宽高
        Map<String, Double> sizeMap = new HashMap<>();
        sizeMap.put("width", (double) widthPd);
        sizeMap.put("height", (double) heightPd);
        if (methodChannel != null) {
            methodChannel.invokeMethod("setSize", sizeMap);
        }
    }

    @Override
    public void onLayoutChange(View v, int left, int top, int right, int bottom, int oldLeft, int oldTop, int oldRight, int oldBottom) {
        Log.i(TAG, "onLayoutChange left:" + left + " top:" + top + " right:" + right + " bottom:" + bottom);

        if (right > 0 && bottom > 0) {
            int width = right - left;
            int height = bottom - top;
            Log.i(TAG, "onLayoutChange width:" + width + " height:" + height);
            setFlutterViewSize(width, height);
        }
    }

}