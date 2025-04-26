package com.example.qr_biometric_app

import android.os.Bundle
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine

import com.example.qr_biometric_app.biometric.BiometricAuthApi
import com.example.qr_biometric_app.biometric.BiometricAuthApiImpl

import com.example.qr_biometric_app.qrscan.platform.QrScannerApi
import com.example.qr_biometric_app.qrscan.data.QrScannerApiImpl

class MainActivity : FlutterFragmentActivity() {

    private lateinit var qrScannerApiImpl: QrScannerApiImpl

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // ⚡ Inicializamos Biometría (como ya tenías)
        BiometricAuthApi.setUp(flutterEngine.dartExecutor.binaryMessenger, BiometricAuthApiImpl(this))

        // ⚡ Inicializamos el QR Scanner
        qrScannerApiImpl = QrScannerApiImpl(this)
        QrScannerApi.setUp(flutterEngine.dartExecutor.binaryMessenger, qrScannerApiImpl)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: android.content.Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        
        // ⚡ Capturamos el resultado de la actividad de escaneo QR
        qrScannerApiImpl.handleResult(requestCode, resultCode, data)
    }
}
