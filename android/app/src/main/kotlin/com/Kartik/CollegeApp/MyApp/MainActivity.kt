// MainActivity.kt
package com.Kartik.CollegeApp.MyApp

import android.content.Context
import android.net.wifi.WifiManager
import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "hotspot_channel"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "turnOnHotspot") {
                val wifiManager = applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager?
                wifiManager?.isWifiEnabled = false // Disable Wi-Fi to enable hotspot
                wifiManager?.startLocalOnlyHotspot(object : WifiManager.LocalOnlyHotspotCallback() {
                    override fun onStarted(reservation: WifiManager.LocalOnlyHotspotReservation) {
                        val ssid = reservation.wifiConfiguration.SSID
                        val password = reservation.wifiConfiguration.preSharedKey
                        reservation.close()
                        result.success("$ssid:$password")
                    }

                    override fun onFailed(reason: Int) {
                        result.error("HOTSPOT_ERROR", "Failed to start hotspot", null)
                    }
                }, null)
            } else if (call.method == "getConnectedDevices") {
                // Implement code to retrieve connected devices here
                // You can use ARP tables or other means to get connected devices
                // This part will vary depending on your requirements and network setup
                val connectedDevices = "Device A, Device B, Device C" // Replace with actual devices
                result.success(connectedDevices)
            } else {
                result.notImplemented()
            }
        }
    }
}
