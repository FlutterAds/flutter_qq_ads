package com.zero.flutter_qq_ads.page;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.view.View;
import android.widget.FrameLayout;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.localbroadcastmanager.content.LocalBroadcastManager;

import com.qq.e.ads.nativ.NativeExpressADView;
import com.zero.flutter_qq_ads.PluginDelegate;
import com.zero.flutter_qq_ads.event.AdEventAction;
import com.zero.flutter_qq_ads.load.FeedAdManager;

import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

/**
 * Feed 信息流广告 View
 */
class AdFeedView extends BaseAdPage implements PlatformView {
    private final String TAG = AdFeedView.class.getSimpleName();
    @NonNull
    private final FrameLayout frameLayout;
    private final PluginDelegate pluginDelegate;
    private int id;
    private NativeExpressADView fad;
    private BroadcastReceiver receiver;


    AdFeedView(@NonNull Context context, int id, @Nullable Map<String, Object> creationParams, PluginDelegate pluginDelegate) {
        this.id = id;
        this.pluginDelegate = pluginDelegate;
        frameLayout = new FrameLayout(context);
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
            if (frameLayout.getChildCount() > 0) {
                frameLayout.removeAllViews();
            }
            fad.render();
            frameLayout.addView(fad);
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
                if (AdEventAction.onAdClosed.equals(event) || AdEventAction.onAdError.equals(event)) {
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
    }

}