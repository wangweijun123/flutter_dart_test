package com.example.flutter_dart_test

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.os.Handler
import android.os.Looper
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {
    // dart 与 kotlin，通道名字必须一致
    private val CHANNEL = "samples.flutter.dev/battery"
    private val METHOD_GETBATTERYLEVEL = "getBatteryLevel"
    private val METHOD_OPENNATIVEPAGE = "openNativePage"
    private val TAG = "flutter_xxxx"

    // 方法在flutter enginer 配置完成之后调用，这个可以注册方法监听
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        Log.e(TAG, "MainActivity configureFlutterEngine ..xxx..")
        val methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL);
        methodChannel.setMethodCallHandler {
            // This method is invoked on the main thread.
                call, result ->
            Log.d(TAG,"call.method = ${call.method}");
            if (call.method == METHOD_GETBATTERYLEVEL) {
                var id = call.argument<String>("id")
                var userName = call.argument<String>("userName")
                Log.d(TAG, "从dart端传过来参数 id= $id, name=$userName")
                val batteryLevel = getBatteryLevel()

                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else if (call.method == METHOD_OPENNATIVEPAGE){
                runOnUiThread {
                    Log.e(TAG, "MainActivity startActivity ...")
                    startActivity(Intent(this, SecondActivity::class.java));
                }
            } else {
                result.notImplemented()
            }
        }


        Handler(Looper.getMainLooper()).postDelayed({
            Log.d(TAG, "给dart 发送消息")
            val argus = mapOf<String, String>("width" to "100", "height" to "300")
            methodChannel.invokeMethod("getDartVersion", argus, object : MethodChannel.Result{
                override fun success(result: Any?) {
                    Log.d(TAG, "success , result=$result")
                }

                override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                    Log.d(TAG, "success , errorCode=$errorCode")
                }

                override fun notImplemented() {
                    Log.d(TAG, "notImplemented")
                }

            })
        }, 5000);

    }

    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }

        return batteryLevel
    }

}
