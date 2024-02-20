package com.example.local_file_transfer

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val channel = "app.local_file_transfer.com/test_channel";

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor, channel)
            .setMethodCallHandler { call, result ->
                if (call.method == "helloWorld") {
                    result.success("Hello World from Android 😘")
                } else {
                    result.notImplemented()
                }
            }
    }
}
