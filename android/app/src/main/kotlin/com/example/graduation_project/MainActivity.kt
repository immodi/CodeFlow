package com.example.graduation_project

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    private val CHANNEL = "dummy_service"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "startService") {
                    val intent = Intent(this, DummyService::class.java)
                    startForegroundService(intent)
                    result.success("Service started")
                }
            }
    }
}
