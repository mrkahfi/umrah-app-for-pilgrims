package com.example.app_jamaah_boilerplate

interface StepListener {
    fun step(timeNs: Long, velocityEstimates: Float)
}