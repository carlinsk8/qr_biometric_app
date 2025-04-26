package com.example.qr_biometric_app.qrscan.presentation

import android.util.Log
import androidx.camera.core.ImageProxy
import com.google.mlkit.vision.barcode.BarcodeScanning
import com.google.mlkit.vision.common.InputImage
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.SharedFlow
import kotlinx.coroutines.launch

class QrScannerProcessor {

    private val _qrFlow = MutableSharedFlow<String>(replay = 0)
    val qrFlow: SharedFlow<String> = _qrFlow

    private val scanner = BarcodeScanning.getClient()

    fun processImage(imageProxy: ImageProxy) {
        val mediaImage = imageProxy.image
        if (mediaImage != null) {
            val image = InputImage.fromMediaImage(mediaImage, imageProxy.imageInfo.rotationDegrees)

            scanner.process(image)
                .addOnSuccessListener { barcodes ->
                    barcodes.forEach { barcode ->
                        barcode.rawValue?.let { value ->
                            Log.d("QrScannerProcessor", "QR detectado: $value")
                            GlobalScope.launch {
                                _qrFlow.emit(value)
                            }
                        }
                    }
                }
                .addOnFailureListener { e ->
                    Log.e("QrScannerProcessor", "Error procesando imagen", e)
                }
                .addOnCompleteListener {
                    imageProxy.close()
                }
        } else {
            imageProxy.close()
        }
    }
}
