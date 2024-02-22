package com.example.local_file_transfer

import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.location.LocationManager
import android.net.Uri
import android.net.wifi.WifiConfiguration
import android.net.wifi.WifiManager
import android.net.wifi.WifiManager.LocalOnlyHotspotCallback
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.provider.Settings
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat
import java.math.BigInteger
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException
import java.util.Random

class HotspotManager private constructor(context: Context) {
    // Properties

    private val wifiManager: WifiManager
    private val locationManager: LocationManager
    private val utils: Utils
    private var reservation: WifiManager.LocalOnlyHotspotReservation? = null

    private var ssid: String = ""
    private var password: String = ""

    // Init

    companion object {
        @Volatile
        private var instance: HotspotManager? = null

        fun getInstance(context: Context) =
            instance ?: synchronized(this) {
                instance ?: HotspotManager(context).also { instance = it }
            }
    }

    init {
        wifiManager =
            context.applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager
        locationManager =
            context.applicationContext.getSystemService(Context.LOCATION_SERVICE) as LocationManager
        utils = Utils()
    }

    // Methods
    fun startHotspot(context: Context) {
        val providerEnabled: Boolean =
            locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)

        if (isDeviceConnectedToWifi()) {
            return
        }

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            if (utils.checkLocationPermission(context) && providerEnabled && !isWifiApEnabled()) {
                try {
                    wifiManager.startLocalOnlyHotspot(object : LocalOnlyHotspotCallback() {
                        override fun onStarted(reservation: WifiManager.LocalOnlyHotspotReservation) {
                            super.onStarted(reservation)
                            this@HotspotManager.reservation = reservation
                            try {
                                ssid = reservation.wifiConfiguration!!.SSID
                                password = reservation.wifiConfiguration!!.preSharedKey
//                                onSuccessListener.onSuccess(ssid, password)
                            } catch (e: java.lang.Exception) {
                                e.printStackTrace()
                            }
                        }

                        override fun onFailed(reason: Int) {
                            super.onFailed(reason)
                        }
                    }, Handler(Looper.getMainLooper()))
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }
        } else {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                if (!utils.checkLocationPermission(context)) {
                    return
                }
                if (!utils.checkWriteSettingPermission(context)) {
                    return
                }
            }
            try {
                ssid = "AndroidAP_" + Random().nextInt(10000)
                password = getRandomPassword()
                val wifiConfiguration = WifiConfiguration()
                wifiConfiguration.SSID = ssid
                wifiConfiguration.preSharedKey = password
                wifiConfiguration.allowedAuthAlgorithms.set(WifiConfiguration.AuthAlgorithm.SHARED)
                wifiConfiguration.allowedProtocols.set(WifiConfiguration.Protocol.RSN)
                wifiConfiguration.allowedProtocols.set(WifiConfiguration.Protocol.WPA)
                wifiConfiguration.allowedKeyManagement.set(WifiConfiguration.KeyMgmt.WPA_PSK)
                wifiManager.setWifiEnabled(false)
                setWifiApEnabled(wifiConfiguration, true)
//                onSuccessListener.onSuccess(ssid, password)
            } catch (e: java.lang.Exception) {
                e.printStackTrace()
            }
        }
    }

    fun isDeviceConnectedToWifi(): Boolean {
        return wifiManager.dhcpInfo.ipAddress != 0
    }

    @Throws(java.lang.Exception::class)
    private fun setWifiApEnabled(wifiConfiguration: WifiConfiguration, enable: Boolean) {
        val method = wifiManager.javaClass.getMethod(
            "setWifiApEnabled",
            WifiConfiguration::class.java,
            Boolean::class.javaPrimitiveType
        )
        method.invoke(wifiManager, wifiConfiguration, enable)
    }

    private fun isWifiApEnabled(): Boolean {
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                reservation?.close()
            }
//            else {
//
//            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
        return false
    }

    private fun getRandomPassword(): String {
        try {
            val ms = MessageDigest.getInstance("MD5")
            val bytes = ByteArray(10)
            Random().nextBytes(bytes)
            val digest = ms.digest(bytes)
            val bigInt = BigInteger(1, digest)
            return bigInt.toString(16).substring(0, 10)
        } catch (e: NoSuchAlgorithmException) {
            e.printStackTrace()
        }
        return "abbcccdddd1234"
    }

    // Interfaces
    interface onFailureListener {
        fun onFailure(failureCode: Int, e: Exception?)
    }

    interface OnSuccessListener {
        fun onSuccess(ssid: String, password: String)
    }

    // Classes
    class Utils {
        fun checkLocationPermission(context: Context): Boolean {
            return ActivityCompat.checkSelfPermission(
                context,
                Manifest.permission.ACCESS_FINE_LOCATION
            ) == PackageManager.PERMISSION_GRANTED
        }

        fun askLocationPermission(activity: Activity, requestCode: Int) {
            ActivityCompat.requestPermissions(activity, Array<String>(1) {
                Manifest.permission.ACCESS_FINE_LOCATION
            }, requestCode)
        }

        @RequiresApi(Build.VERSION_CODES.M)
        fun askWriteSettingPermission(activity: Activity) {
            val intent: Intent = Intent(Settings.ACTION_MANAGE_WRITE_SETTINGS)
            intent.setData(Uri.parse("package:" + activity.packageName))
            activity.startActivity(intent)
        }

        @RequiresApi(Build.VERSION_CODES.M)
        fun checkWriteSettingPermission(context: Context): Boolean {
            return Settings.System.canWrite(context)
        }

        fun getTetheringSettingIntent(): Intent {
            val intent = Intent()
            intent.setClassName("com.android.settings", "com.android.settings.TetherSettings")
            return intent
        }

        fun askForGpsProvider(activity: Activity) {
            val intent = Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS)
            activity.startActivity(intent)
        }

        fun askForDisableWifi(activity: Activity) {
            val intent = Intent(Settings.ACTION_WIFI_SETTINGS)
            activity.startActivity(intent)
        }
    }
}
