package com.zero.flutter_qq_ads.page;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.AppCompatImageView;

import android.os.Bundle;
import android.util.Log;
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
        posId=getIntent().getStringExtra(PluginDelegate.KEY_POSID);
        SplashAD splashAD = new SplashAD(this, posId, this, 0);
        splashAD.fetchAndShowIn(ad_container);
    }


    @Override
    public void onADDismissed() {

    }

    @Override
    public void onNoAD(AdError adError) {
        Log.d(TAG,"onNoAD:"+adError.getErrorMsg());
    }

    @Override
    public void onADPresent() {

    }

    @Override
    public void onADClicked() {

    }

    @Override
    public void onADTick(long l) {

    }

    @Override
    public void onADExposure() {

    }

    @Override
    public void onADLoaded(long l) {

    }
}