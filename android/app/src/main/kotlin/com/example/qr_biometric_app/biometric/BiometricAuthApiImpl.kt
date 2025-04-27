package com.example.qr_biometric_app.biometric

import android.content.Context
import androidx.biometric.BiometricManager
import androidx.biometric.BiometricPrompt
import androidx.core.content.ContextCompat
import androidx.fragment.app.FragmentActivity

class BiometricAuthApiImpl(private val context: Context) : BiometricAuthApi {

    private lateinit var biometricPrompt: BiometricPrompt

    override fun authenticate(callback: (Result<Boolean>) -> Unit) {
        val activity = context as? FragmentActivity ?: run {
            callback(Result.success(false))
            return
        }

        val biometricManager = BiometricManager.from(context)

        // Diagnóstico
        val result = biometricManager.canAuthenticate(
            BiometricManager.Authenticators.BIOMETRIC_STRONG
        )

        when (result) {
            BiometricManager.BIOMETRIC_SUCCESS -> println("✅ Biometría disponible y registrada.")
            BiometricManager.BIOMETRIC_ERROR_NO_HARDWARE -> println("❌ No hay hardware biométrico en este dispositivo.")
            BiometricManager.BIOMETRIC_ERROR_HW_UNAVAILABLE -> println("❌ Hardware biométrico no disponible.")
            BiometricManager.BIOMETRIC_ERROR_NONE_ENROLLED -> println("❌ No hay huellas registradas en este dispositivo.")
            else -> println("❓ Otro resultado: $result")
        }

        val canAuthenticate = biometricManager.canAuthenticate(
            BiometricManager.Authenticators.BIOMETRIC_STRONG or BiometricManager.Authenticators.DEVICE_CREDENTIAL
        )

        if (canAuthenticate != BiometricManager.BIOMETRIC_SUCCESS) {
            callback(Result.success(false))
            return
        }

        val executor = ContextCompat.getMainExecutor(context)
        var isResultSubmitted = false

        // Inicializamos biometricPrompt antes de usarlo
        biometricPrompt = BiometricPrompt(
            activity,
            executor,
            object : BiometricPrompt.AuthenticationCallback() {

                override fun onAuthenticationSucceeded(result: BiometricPrompt.AuthenticationResult) {
                    if (!isResultSubmitted) {
                        isResultSubmitted = true
                        callback(Result.success(true))
                    }
                }

                override fun onAuthenticationError(errorCode: Int, errString: CharSequence) {
                    if (!isResultSubmitted) {
                        isResultSubmitted = true
                        callback(Result.success(false))
                    }
                }

                override fun onAuthenticationFailed() {
                    println("Authentication failed. User can retry.")
                    // Android maneja cambiar a PIN automáticamente si fallan varias veces.
                }
            }
        )

        // Ahora sí autenticamos
        biometricPrompt.authenticate(
            BiometricPrompt.PromptInfo.Builder()
                .setTitle("Autenticación Biométrica o PIN")
                .setSubtitle("Usa tu huella, rostro o PIN para iniciar sesión")
                .setAllowedAuthenticators(
                    BiometricManager.Authenticators.BIOMETRIC_STRONG or BiometricManager.Authenticators.DEVICE_CREDENTIAL
                )
                .build()
        )
    }
}
