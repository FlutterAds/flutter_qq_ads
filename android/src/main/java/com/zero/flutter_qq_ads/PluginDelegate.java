package com.zero.flutter_qq_ads;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;

import com.qq.e.comm.managers.GDTADManager;
import com.zero.flutter_qq_ads.page.AdSplashActivity;
import com.zero.flutter_qq_ads.page.InterstitialPage;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/// 插件代理
public class PluginDelegate implements MethodChannel.MethodCallHandler,EventChannel.StreamHandler{
    private final String TAG = PluginDelegate.class.getSimpleName();
    // Flutter 插件绑定对象
    public FlutterPlugin.FlutterPluginBinding bind;
    // 当前 Activity
    public Activity activity;
    // 返回通道
    private MethodChannel.Result result;
    // 事件通道
    private EventChannel.EventSink eventSink;
    // 插件代理对象
    private static PluginDelegate _instance;
    public static  PluginDelegate getInstance(){
        return _instance;
    }

    // 广告参数
    public static final String KEY_POSID = "posId";
    // logo 参数
    public static final String KEY_LOGO = "logo";

    /**
     * 插件代理构造函数构造函数
     * @param activity Activity
     * @param pluginBinding FlutterPluginBinding
     */
    public PluginDelegate(Activity activity, FlutterPlugin.FlutterPluginBinding pluginBinding){
        this.activity=activity;
        this.bind=pluginBinding;
        _instance=this;
    }

    /**
     * 方法通道调用
     * @param call 方法调用对象
     * @param result 回调结果对象
     */
    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        String method=call.method;
        Log.d(TAG, "MethodChannel onMethodCall method:"+method +" arguments:"+call.arguments);
        if ("getPlatformVersion".equals(method)) {
            getPlatformVersion(call, result);
        }else if ("initAd".equals(method)){
            initAd(call, result);
        }else if ("showSplashAd".equals(method)){
            showSplashAd(call, result);
        }else if ("showInterstitialAd".equals(method)){
            showInterstitialAd(call, result);
        }else {
            result.notImplemented();
        }
    }

    /**
     * 建立事件通道监听
     * @param arguments 参数
     * @param events 事件回调对象
     */
    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        Log.d(TAG, "EventChannel onListen arguments:"+arguments);
        eventSink = events;
    }

    /**
     * 取消事件通道监听
     * @param arguments 参数
     */
    @Override
    public void onCancel(Object arguments) {
        Log.d(TAG, "EventChannel onCancel");
        eventSink = null;
    }

    /**
     * 添加事件
     * @param event 事件
     */
    public void addEvent(Object event){
        if(eventSink!=null){
            Log.d(TAG, "EventChannel addEvent event:" + event.toString());
            eventSink.success(event);
        }
    }

    /**
     * demo
     *
     * @param call   MethodCall
     * @param result Result
     */
    public void getPlatformVersion(MethodCall call, MethodChannel.Result result) {
//        String id = call.argument("id");
        result.success("Android " + android.os.Build.VERSION.RELEASE);
    }

    /**
     * 初始化广告
     *
     * @param call   MethodCall
     * @param result Result
     */
    public void initAd(MethodCall call, MethodChannel.Result result) {
        String appId = call.argument("appId");
        boolean initSuccess=GDTADManager.getInstance().initWith(activity,appId);
        result.success(initSuccess);
    }

    /**
     * 显示开屏广告
     *
     * @param call   MethodCall
     * @param result Result
     */
    public void showSplashAd(MethodCall call, MethodChannel.Result result) {
        String posId = call.argument(KEY_POSID);
        String logo = call.argument(KEY_LOGO);
        Intent intent = new Intent(activity, AdSplashActivity.class);
        intent.putExtra(KEY_POSID,posId);
        intent.putExtra(KEY_LOGO,logo);
        activity.startActivity(intent);
        result.success(true);
    }

    /**
     * 显示开屏广告
     *
     * @param call   MethodCall
     * @param result Result
     */
    public void showInterstitialAd(MethodCall call, MethodChannel.Result result) {
        String posId = call.argument(KEY_POSID);
        InterstitialPage iad=new InterstitialPage();
        iad.showAd(activity,posId);
        result.success(true);
    }
}
