package com.example.app_jamaah_boilerplate

import android.accessibilityservice.AccessibilityService
import android.content.Context
import android.content.Intent
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.os.Bundle
import android.provider.Settings
import android.text.TextUtils
import android.util.Log
import android.widget.Toast
import com.afollestad.materialdialogs.MaterialDialog
import com.afollestad.materialdialogs.Theme
import com.midtrans.sdk.corekit.callback.TransactionFinishedCallback
import com.midtrans.sdk.corekit.core.MidtransSDK
import com.midtrans.sdk.corekit.models.snap.TransactionResult
import com.midtrans.sdk.uikit.SdkUIFlowBuilder
import io.flutter.embedding.android.FlutterActivity
//import io.flutter.app.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity(), TransactionFinishedCallback, SensorEventListener, StepListener  {

    companion object {
        const val CHANNEL = "com.example.app_jamaah_boilerplate.channel"
        const val KEY_NATIVE_MIDTRANS = "showMidtrans"
        const val KEY_NATIVE_SAI = "step"
        const val KEY_NATIVE = "showNativeView"
    }

    private var stepDetector: StepDetector? = null
    private var sensorManager: SensorManager? = null
    private var accelerator: Sensor? = null
    private var numbSteps = 0
    private var steps = 0
    private var forService: Intent? = null

    override fun provideFlutterEngine(context: Context): FlutterEngine? {
        return FlutterEngineCache.getInstance().get("my_engine_id")
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        stepDetector = StepDetector()
        sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager?
        accelerator = sensorManager?.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)
        stepDetector?.registerListener(this)
        forService = Intent(this, MyService::class.java)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        Log.d("ENGINEE", "configureFlutterEngine: ")
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == KEY_NATIVE) {
//                val intent = Intent(this, NativeAndroidActivity::class.java)
//                startActivity(intent)
//                result.success(true)
                if (!isAccessibilityOn(this, AccessibilityServiceMp::class.java)) {
                    val intent = Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS)
                    this.startActivity(intent)
                    Toast.makeText(this, "Enable Service Accessibility MP Access in Setting", Toast.LENGTH_SHORT).show()
                }else{
                    val launchIntent =
                            packageManager.getLaunchIntentForPackage("com.sejel.eatamrna")
                    startActivity(launchIntent)
                }
            } else if (call.method == KEY_NATIVE_MIDTRANS) {
                val id = (""+call.argument("id"))
                val name = (""+call.argument("name"))
                val price = (""+call.argument("price"))
                val qty = (""+call.argument("qty"))
                initMidtransSDK()
                MidtransSDK.getInstance().transactionRequest = DataCustomer.transactionRequest(
                        id = id,
                        price = price.toLong(),
                        qty = qty.toInt(),
                        name = name
                )
                MidtransSDK.getInstance().startPaymentUiFlow(this)
            } else if (call.method == KEY_NATIVE_SAI) {
                Log.d("CHANNEL", "ENTER NATIVE SIDE")
                stepCounter()
                result.success(steps.toString())
                Log.d("SEND FROM CHANNEL ", steps.toString())
            } else {
                result.notImplemented()
            }
        }
    }

//    fun flutterChannel() {
//        val channel = MethodChannel(getFlutterView(), "sai")
//        channel.setMethodCallHandler(object : MethodChannel.MethodCallHandler() {
//            fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
//                when (call.method) {
//                    "step" -> {
//                        Log.d("CHANNEL", "ENTER NATIVE SIDE")
//                        stepCounter()
//                        result.success(steps.toString())
//                        Log.d("SEND FROM CHANNEL ", steps.toString())
//                    }
//                    "startService" -> {
//                        startService()
//                        result.success("Service Started")
//                    }
//                    "stopService" -> {
//                        stopService()
//                        result.success("Service Stoped")
//                    }
//                }
//            }
//        })
//    }

    private fun initMidtransSDK(){
        SdkUIFlowBuilder.init()
                .setContext(this)
                .setMerchantBaseUrl("https://midtrans-php.herokuapp.com/index.php/")
                .setClientKey("SB-Mid-client-w4Jp6T1R7aet1zeU")
                .setTransactionFinishedCallback(this)
                .enableLog(true)
                .buildSDK()
    }

    override fun onTransactionFinished(result: TransactionResult?) {
        if (result?.response != null){
            when (result.status){
                TransactionResult.STATUS_SUCCESS -> Toast.makeText(this, "SUCCESS ${result.response.transactionId}", Toast.LENGTH_SHORT).show()
                TransactionResult.STATUS_PENDING -> Toast.makeText(this, "PENDING ${result.response.transactionId}", Toast.LENGTH_SHORT).show()
                TransactionResult.STATUS_FAILED -> Toast.makeText(this, "FAILED ${result.response.transactionId}", Toast.LENGTH_SHORT).show()
            }
            result.response.validationMessages
        } else if (result != null) {
            if (result.isTransactionCanceled) {
                Toast.makeText(this, "CANCELLED", Toast.LENGTH_SHORT).show()
            } else {
                if (result.status.equals(TransactionResult.STATUS_INVALID, ignoreCase = true)){
                    Toast.makeText(this, "INVALID", Toast.LENGTH_SHORT).show()
                }else{
                    Toast.makeText(this, "FAILURE", Toast.LENGTH_SHORT).show()
                }
            }
        }
    }

    private fun isAccessibilityOn(context: Context, clazz: Class<out AccessibilityService>): Boolean {
        var accessibilityEnabled = 0
        val service = context.packageName + "/" + clazz.canonicalName
        try {
            accessibilityEnabled = Settings.Secure.getInt(
                    context.applicationContext.contentResolver,
                    Settings.Secure.ACCESSIBILITY_ENABLED
            )
        } catch (ignored: Settings.SettingNotFoundException) {}

        val colonSplitter = TextUtils.SimpleStringSplitter(':')

        if (accessibilityEnabled == 1) {
            val settingValue = Settings.Secure.getString(
                    context.applicationContext.contentResolver,
                    Settings.Secure.ENABLED_ACCESSIBILITY_SERVICES
            )
            if (settingValue != null) {
                colonSplitter.setString(settingValue)
                while (colonSplitter.hasNext()) {
                    val accessibilityService = colonSplitter.next()

                    if (accessibilityService.equals(service, ignoreCase = true)) {
                        return true
                    }
                }
            }
        }
        return false
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {
        Log.d("ACCURACY", accuracy.toString())
    }

    override fun onSensorChanged(event: SensorEvent?) {
        if (event?.sensor?.type == Sensor.TYPE_ACCELEROMETER) {
            stepDetector?.updateAccel(event.timestamp, event.values[0], event.values[1], event.values[2])
        }
    }

    private fun stepCounter() {
        numbSteps = 0
        sensorManager?.registerListener(this, accelerator, SensorManager.SENSOR_DELAY_FASTEST)
    }

    override fun onDestroy() {
        super.onDestroy()
        stopService(forService)
    }

//    private fun startService() {
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//            startForegroundService(forService)
//        } else {
//            startService(forService)
//        }
//    }

    override fun step(timeNs: Long, velocityEstimates: Float) {
        numbSteps++
        steps = numbSteps
        Log.d("STEP ", steps.toString())
        when {
            steps == 450 -> {
                val dialog: MaterialDialog = MaterialDialog.Builder(this)
                        .theme(Theme.LIGHT)
                        .content("Apakah sudah sampai?")
                        .positiveText("Sudah")
                        .onPositive { dialog, _ ->
                            sensorManager?.unregisterListener(this@MainActivity)
                            numbSteps = 0
                            Log.d("SENSOR", "UNREGISTERED")
                            dialog.dismiss()
                        }
                        .negativeText("Belum")
                        .onNegative { dialog, _ -> dialog.dismiss() }
                        .build()
                dialog.show()
            }
            steps == 500 -> {
                val dialog: MaterialDialog = MaterialDialog.Builder(this)
                        .theme(Theme.LIGHT)
                        .content("Sudah sampai")
                        .positiveText("Oke")
                        .onPositive { dialog, _ ->
                            sensorManager?.unregisterListener(this@MainActivity)
                            numbSteps = 0
                            Log.d("SENSOR", "UNREGISTERED")
                            dialog.dismiss()
                        }
                        .build()
                dialog.show()
            }
            steps > 500 -> {
                sensorManager?.unregisterListener(this)
                numbSteps = 0
                Log.d("SENSOR", "UNREGISTERED")
            }
        }
    }
}
