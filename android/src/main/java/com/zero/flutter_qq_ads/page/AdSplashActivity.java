package com.zero.flutter_qq_ads.page;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.AppCompatImageView;

import android.content.Context;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.widget.FrameLayout;

import com.qq.e.ads.splash.SplashAD;
import com.qq.e.ads.splash.SplashADListener;
import com.qq.e.comm.util.AdError;
import com.zero.flutter_qq_ads.PluginDelegate;
import com.zero.flutter_qq_ads.R;

/**
 * 开屏广告
 */
public class AdSplashActivity extends AppCompatActivity implements SplashADListener {
    private final String TAG = AdSplashActivity.class.getSimpleName();
    // 广告容器
    private FrameLayout ad_container;
    // 自定义品牌 logo
    private AppCompatImageView ad_logo;
    // 广告位 id
    private String posId;
    // logo 名称
    private String logo;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_ad_splash);
        initView();
        initData();
    }

    /**
     * 初始化View
     */
    private void initView() {
        ad_container = findViewById(R.id.splash_ad_container);
        ad_logo = findViewById(R.id.splash_ad_logo);
    }

    /**
     * 初始化数据
     */
    private void initData() {
        // 获取参数
        posId=getIntent().getStringExtra(PluginDelegate.KEY_POSID);
        logo=getIntent().getStringExtra(PluginDelegate.KEY_LOGO);
        // 创建开屏广告
        SplashAD splashAD = new SplashAD(this, posId, this, 0);
        if(TextUtils.isEmpty(logo)){
            // logo 为空则加载全屏广告
            ad_logo.setVisibility(View.GONE);
            splashAD.fetchFullScreenAndShowIn(ad_container);
        }else{
            // 显示 logo 加载半屏广告
            ad_logo.setVisibility(View.VISIBLE);
            ad_logo.setImageResource(getMipmapId(logo));
            splashAD.fetchAndShowIn(ad_container);
        }
    }


    @Override
    public void onADDismissed() {
        Log.d(TAG,"onADDismissed");
        finishPage();
    }

    @Override
    public void onNoAD(AdError adError) {
        Log.d(TAG,"onNoAD adError:"+adError.getErrorMsg());
        finishPage();
    }

    @Override
    public void onADPresent() {
        Log.d(TAG,"onADPresent");
    }

    @Override
    public void onADClicked() {
        Log.d(TAG,"onADClicked");
    }

    @Override
    public void onADTick(long millisUntilFinished) {
        Log.d(TAG,"onADTick millisUntilFinished："+millisUntilFinished);
    }

    @Override
    public void onADExposure() {
        Log.d(TAG,"onADExposure");
    }

    @Override
    public void onADLoaded(long expireTimestamp) {
        Log.d(TAG,"onADLoaded expireTimestamp："+expireTimestamp);
    }

    /**
     * 完成广告，退出开屏页面
     */
    private void finishPage() {
        finish();
        // 设置退出动画
        overridePendingTransition(0,android.R.anim.fade_out);
    }

    /** 开屏页一定要禁止用户对返回按钮的控制，否则将可能导致用户手动退出了App而广告无法正常曝光和计费 */
    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK || keyCode == KeyEvent.KEYCODE_HOME) {
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }

    /**
     * 获取图片文件的id
     *
     * @param resName
     * @return
     */
    private int getMipmapId(String resName) {
        return getResources().getIdentifier(resName, "mipmap", getPackageName());
    }
}