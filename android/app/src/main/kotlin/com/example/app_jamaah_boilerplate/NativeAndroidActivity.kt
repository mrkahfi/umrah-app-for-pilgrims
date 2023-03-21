package com.example.app_jamaah_boilerplate

import android.os.Bundle
import android.widget.TextView
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
//import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class NativeAndroidActivity : FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_native_android)

        val channel = MethodChannel(FlutterEngine(this).dartExecutor, MainActivity.CHANNEL)

        findViewById<TextView>(R.id.text_view).setOnClickListener {
            Toast.makeText(this, "Message from native world!", Toast.LENGTH_SHORT).show()
            channel.invokeMethod("message", "Hello from native host")
        }
    }
}