package com.flutterapp.yjw.jkdflutter;

import android.annotation.SuppressLint;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Bundle;
import android.widget.Toast;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class ContainerActivity extends FlutterActivity {

    private Toast mToast;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        System.out.println("ContainerActivity");

        GeneratedPluginRegistrant.registerWith(this);
        new MethodChannel(getFlutterView(), "yjw")
                .setMethodCallHandler(new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                        switch (methodCall.method) {
                            case "getBatteryLevel":
                                int batteryLevel = getBatteryLevel();

                                if (batteryLevel != -1) {
                                    result.success(batteryLevel);
                                } else {
                                    result.error("UNAVAILABLE", "Battery level not available.", null);
                                }
                                break;
                            case "toast":
                                if (methodCall.hasArgument("text")) {
                                    Object text = methodCall.argument("text");
                                    if (mToast == null)
                                        mToast = Toast.makeText(getApplicationContext(), ((String) text), Toast.LENGTH_SHORT);
                                    mToast.setText((String) text);
                                    mToast.show();
                                } else {
                                    result.error("UNAVAILABLE", "TEXT NOT PROVIDED.", null);
                                }
                                break;
                            default:
                                result.notImplemented();

                        }
                    }
                });
    }


    @SuppressLint("InlinedApi")
    private int getBatteryLevel() {
        int batteryLevel = -1;
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
                if (batteryManager != null) {
                    batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
                }
            } else {
                Intent intent = new ContextWrapper(getApplicationContext()).
                        registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
                batteryLevel = ((intent != null ? intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) : 0) * 100) /
                        (intent != null ? intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1) : 0);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return batteryLevel;
    }
}
