package com.example.offbeat_pravasi_v2

import android.telephony.SmsManager
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "sms_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "sendSms") {
                val phoneNumber = call.argument<String>("phoneNumber")
                val message = call.argument<String>("message")

                if (phoneNumber != null && message != null) {
                    sendSms(phoneNumber, message, result)
                } else {
                    result.error("ERROR", "Invalid arguments", null)
                }
            }
        }
    }

    private fun sendSms(phoneNumber: String, message: String, result: MethodChannel.Result) {
        try {
            val smsManager = SmsManager.getDefault()
            smsManager.sendTextMessage(phoneNumber, null, message, null, null)
            android.util.Log.d("SMS_LOG", "SMS sent successfully to $phoneNumber")
            result.success("SMS sent successfully!")
        } catch (e: Exception) {
            android.util.Log.e("SMS_LOG", "Failed to send SMS: ${e.message}")
            result.error("SMS_FAILED", "Failed to send SMS: ${e.message}", null)
        }
    }
}
