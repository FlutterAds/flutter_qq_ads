package com.zero.flutter_qq_ads.page;

import android.app.Activity;
import android.util.Log;

import com.qq.e.ads.cfg.VideoOption;
import com.qq.e.ads.interstitial2.UnifiedInterstitialAD;
import com.qq.e.ads.interstitial2.UnifiedInterstitialADListener;
import com.qq.e.comm.util.AdError;
import com.zero.flutter_qq_ads.event.AdErrorEvent;
import com.zero.flutter_qq_ads.event.AdEvent;
import com.zero.flutter_qq_ads.event.AdEventAction;
import com.zero.flutter_qq_ads.event.AdEventHandler;

import java.util.Locale;

// 插屏广告
public class InterstitialPage implements UnifiedInterstitialADListener {
    private final String TAG = InterstitialPage.class.getSimpleName();
    private String posId;
    private UnifiedInterstitialAD iad;

    /**
     * 显示广告
     * @param activity 上下文
     * @param posId 广告位 id
     */
    public void showAd(Activity activity,String posId){
        this.posId=posId;
        iad=getIAD(activity);
        setVideoOption();
        iad.loadAD();
    }


    /**
     * 获取插屏广告
     * @return
     */
    private UnifiedInterstitialAD getIAD(Activity activity) {
        if (this.iad != null) {
            iad.close();
            iad.destroy();
        }
        iad = new UnifiedInterstitialAD(activity, posId, this);
        return iad;
    }


    /**
     *  设置视频参数
     */
    private void setVideoOption() {
        VideoOption.Builder builder = new VideoOption.Builder();
        VideoOption option = builder.build();
//        if(!btnNoOption.isChecked()){
//            option = builder.setAutoPlayMuted(btnMute.isChecked())
//                    .setAutoPlayPolicy(networkSpinner.getSelectedItemPosition())
//                    .setDetailPageMuted(btnDetailMute.isChecked())
//                    .build();
//        }
        iad.setVideoOption(option);
//        iad.setMinVideoDuration(getMinVideoDuration());
//        iad.setMaxVideoDuration(getMaxVideoDuration());

    }

    /**
     * 显示广告
     */
    private void show() {
        if (iad != null && iad.isValid()) {
            iad.show();
        } else {
            Log.d(TAG,"请加载广告并渲染成功后再进行展示 ！ ");
        }
    }

    /**
     * 以 Popup 形式显示广告
     */
    private void showAsPopup() {
        if (iad != null && iad.isValid()) {
            iad.showAsPopupWindow();
        } else {
            Log.d(TAG,"请加载广告并渲染成功后再进行展示 ！ ");
        }
    }

    @Override
    public void onADReceive() {
        // onADReceive之后才可调用getECPM()
        Log.d(TAG, "onADReceive eCPMLevel = " + iad.getECPMLevel()+ ", ECPM: " + iad.getECPM() + ", videoduration=" + iad.getVideoDuration());
        AdEventHandler.getInstance().sendEvent(new AdEvent(this.posId,AdEventAction.onAdLoaded));
    }

    @Override
    public void onVideoCached() {
        // 视频素材加载完成，在此时调用iad.show()或iad.showAsPopupWindow()视频广告不会有进度条。
        Log.i(TAG, "onVideoCached");
    }

    @Override
    public void onNoAD(AdError error) {
        String msg = String.format(Locale.getDefault(), "onNoAD, error code: %d, error msg: %s",
                error.getErrorCode(), error.getErrorMsg());
        Log.e(TAG, msg);
        AdEventHandler.getInstance().sendEvent(new AdErrorEvent(this.posId,error.getErrorCode(),error.getErrorMsg()));
    }

    @Override
    public void onADOpened() {
        Log.i(TAG, "onADOpened");
    }

    @Override
    public void onADExposure() {
        Log.i(TAG, "onADExposure");
        AdEventHandler.getInstance().sendEvent(new AdEvent(this.posId,AdEventAction.onAdExposure));
    }

    @Override
    public void onADClicked() {
        Log.i(TAG, "onADClicked");
        AdEventHandler.getInstance().sendEvent(new AdEvent(this.posId, AdEventAction.onAdClicked));
    }

    @Override
    public void onADLeftApplication() {
        Log.i(TAG, "onADLeftApplication");
    }

    @Override
    public void onADClosed() {
        Log.i(TAG, "onADClosed");
        AdEventHandler.getInstance().sendEvent(new AdEvent(this.posId,AdEventAction.onAdClosed));
    }

    @Override
    public void onRenderSuccess() {
        Log.i(TAG, "onRenderSuccess，建议在此回调后再调用展示方法");
        show();
    }

    @Override
    public void onRenderFail() {
        Log.i(TAG, "onRenderFail");
    }
}