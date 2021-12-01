package com.zero.flutter_qq_ads.load;

import android.app.Activity;
import android.util.Log;

import androidx.annotation.NonNull;

import com.qq.e.ads.nativ.ADSize;
import com.qq.e.ads.nativ.NativeExpressAD;
import com.qq.e.ads.nativ.NativeExpressADView;
import com.qq.e.comm.util.AdError;
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
    private final String TAG = FeedAdManager.class.getSimpleName();
    private MethodChannel.Result result;

    /**
     * 加载信息流广告列表
     * @param call
     * @param result
     */
    public void loadFeedAdList(Activity activity, @NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        this.result=result;
        showAd(activity,call);
    }

    @Override
    public void loadAd(@NonNull MethodCall call) {
        // 获取请求模板广告素材的尺寸
        int width = call.argument("width");
        int height = call.argument("height");
        int count = call.argument("count");
        NativeExpressAD ad=new NativeExpressAD(activity,new ADSize(width,height),this.posId,this);
        ad.loadAD(count);
    }

    @Override
    public void onADLoaded(List<NativeExpressADView> list) {
        Log.i(TAG, "onADLoaded");
        List<Integer> adResultList=new ArrayList<>();
        if (list == null || list.size() == 0) {
            this.result.success(adResultList);
            return;
        }
        for (NativeExpressADView adItem : list) {
            int key=adItem.hashCode();
            adResultList.add(key);
            FeedAdManager.getInstance().putAd(key,adItem);
        }
        // 添加广告事件
        sendEvent(AdEventAction.onAdLoaded);
        this.result.success(adResultList);
    }

    @Override
    public void onRenderFail(NativeExpressADView nativeExpressADView) {

    }

    @Override
    public void onRenderSuccess(NativeExpressADView nativeExpressADView) {
        Log.i(TAG, "onRenderSuccess");
    }

    @Override
    public void onADExposure(NativeExpressADView nativeExpressADView) {

    }

    @Override
    public void onADClicked(NativeExpressADView nativeExpressADView) {

    }

    @Override
    public void onADClosed(NativeExpressADView nativeExpressADView) {

    }

    @Override
    public void onADLeftApplication(NativeExpressADView nativeExpressADView) {

    }

    @Override
    public void onADOpenOverlay(NativeExpressADView nativeExpressADView) {

    }

    @Override
    public void onADCloseOverlay(NativeExpressADView nativeExpressADView) {

    }

    @Override
    public void onNoAD(AdError error) {
        String msg = String.format(Locale.getDefault(), "onError, error code: %d, error msg: %s",
                error.getErrorCode(), error.getErrorMsg());
        Log.i(TAG, "onError, adError=" + msg);
        sendErrorEvent(error.getErrorCode(), error.getErrorMsg());
    }

    /*@Override
    public void onError(int i, String s) {
        Log.e(TAG, "onError code:" + i + " msg:" + s);
        sendErrorEvent(i, s);
        this.result.error(""+i,s,s);
    }


    @Override
    public void onNativeExpressAdLoad(List<TTNativeExpressAd> list) {
        List<Integer> adResultList=new ArrayList<>();
        Log.i(TAG, "onNativeExpressAdLoad");
        if (list == null || list.size() == 0) {
            this.result.success(adResultList);
            return;
        }
        for (TTNativeExpressAd adItem : list) {
            int key=adItem.hashCode();
            adResultList.add(key);
            FeedAdManager.getInstance().putAd(key,adItem);
        }
        // 添加广告事件
        sendEvent(AdEventAction.onAdLoaded);
        this.result.success(adResultList);
    }*/
}
