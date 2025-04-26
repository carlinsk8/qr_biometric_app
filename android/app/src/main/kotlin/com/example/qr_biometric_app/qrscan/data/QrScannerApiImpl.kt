package com.example.qr_biometric_app.qrscan.data

import android.app.Activity
import android.content.Intent
import com.example.qr_biometric_app.qrscan.platform.QrScannerApi

class QrScannerApiImpl(private val activity: Activity) : QrScannerApi {

    private var pendingCallback: ((Result<String>) -> Unit)? = null

    override fun scanQrCode(callback: (Result<String>) -> Unit) {
        try {
            pendingCallback = callback
            val intent = Intent(activity, com.example.qr_biometric_app.qrscan.presentation.QrScannerActivity::class.java)
            activity.startActivityForResult(intent, 1001)
        } catch (e: Exception) {
            callback(Result.failure(e))
        }
    }

    fun handleResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode == 1001) {
            if (resultCode == Activity.RESULT_OK) {
                val qrResult = data?.getStringExtra("qrResult")
                if (!qrResult.isNullOrEmpty()) {
                    pendingCallback?.invoke(Result.success(qrResult))
                } else {
                    pendingCallback?.invoke(Result.failure(Exception("QR vacío")))
                }
            } else {
                pendingCallback?.invoke(Result.failure(Exception("Escaneo cancelado")))
            }
        }
    }
}
