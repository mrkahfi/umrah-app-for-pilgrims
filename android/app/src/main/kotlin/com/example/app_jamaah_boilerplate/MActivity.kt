package com.example.app_jamaah_boilerplate

class MActivity {
//    private var stepDetector: StepDetector? = null
//    private var sensorManager: SensorManager? = null
//    private var accel: Sensor? = null
//    private var numbSteps = 0
//    private var steps = 0
//    private var forService: Intent? = null
//    protected fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//        GeneratedPluginRegistrant.registerWith(this)
//        stepDetector = StepDetector()
//        sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager?
//        accel = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)
//        stepDetector!!.registerListener(this)
//        forService = Intent(this, MyService::class.java)
//        flutterChannel()
//    }
//
//    fun flutterChannel() {
//        val channel = MethodChannel(getFlutterView(), "sai")
//        channel.setMethodCallHandler(object : MethodCallHandler() {
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
//
//    fun onSensorChanged(event: SensorEvent) {
//        if (event.sensor.getType() === Sensor.TYPE_ACCELEROMETER) {
//            stepDetector!!.updateAccel(event.timestamp, event.values.get(0), event.values.get(1), event.values.get(2))
//        }
//    }
//
//    fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {
//        Log.d("ACCURACY", accuracy.toString())
//    }
//
//    fun stepCounter() {
//        numbSteps = 0
//        sensorManager.registerListener(this, accel, SensorManager.SENSOR_DELAY_FASTEST)
//    }
//
//    fun step(timeNs: Long, velocityEstimates: Float) {
//        numbSteps++
//        steps = numbSteps
//        Log.d("STEP ", steps.toString())
//        if (steps == 450) {
//            val dialog: MaterialDialog = Builder(this)
//                    .theme(Theme.LIGHT)
//                    .content("Apakah sudah sampai?")
//                    .positiveText("Sudah")
//                    .onPositive(object : SingleButtonCallback() {
//                        fun onClick(@NonNull dialog: MaterialDialog, @NonNull which: DialogAction?) {
//                            sensorManager.unregisterListener(this@MainActivity)
//                            numbSteps = 0
//                            Log.d("SENSOR", "UNREGISTERED")
//                            dialog.dismiss()
//                        }
//                    })
//                    .negativeText("Belum")
//                    .onNegative(object : SingleButtonCallback() {
//                        fun onClick(@NonNull dialog: MaterialDialog, @NonNull which: DialogAction?) {
//                            dialog.dismiss()
//                        }
//                    })
//                    .build()
//            dialog.show()
//        } else if (steps == 500) {
//            val dialog: MaterialDialog = Builder(this)
//                    .theme(Theme.LIGHT)
//                    .content("Sudah sampai")
//                    .positiveText("Oke")
//                    .onPositive(object : SingleButtonCallback() {
//                        fun onClick(@NonNull dialog: MaterialDialog, @NonNull which: DialogAction?) {
//                            sensorManager.unregisterListener(this@MainActivity)
//                            numbSteps = 0
//                            Log.d("SENSOR", "UNREGISTERED")
//                            dialog.dismiss()
//                        }
//                    })
//                    .build()
//            dialog.show()
//        } else if (steps > 500) {
//            sensorManager.unregisterListener(this)
//            numbSteps = 0
//            Log.d("SENSOR", "UNREGISTERED")
//        }
//    }
//
//    protected fun onDestroy() {
//        super.onDestroy()
//        stopService(forService)
//    }
//
//    private fun startService() {
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//            startForegroundService(forService)
//        } else {
//            startService(forService)
//        }
//    }
}