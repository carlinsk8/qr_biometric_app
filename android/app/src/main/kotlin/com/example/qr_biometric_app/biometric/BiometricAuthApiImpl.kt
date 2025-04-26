package com.example.qr_biometric_app.biometric

import android.content.Context
import androidx.biometric.BiometricManager
import androidx.biometric.BiometricPrompt
import androidx.core.content.ContextCompat
import androidx.fragment.app.FragmentActivity

class BiometricAuthApiImpl(private val context: Context) : BiometricAuthApi {

    override fun authenticate(callback: (Result<Boolean>) -> Unit) {
        val activity = context as? FragmentActivity ?: run {
            callback(Result.success(false))
            return
        }

        val canAuthenticate = BiometricManager.from(context)
            .canAuthenticate(BiometricManager.Authenticators.BIOMETRIC_STRONG)

        if (canAuthenticate != BiometricManager.BIOMETRIC_SUCCESS) {
            callback(Result.success(false))
            return
        }

        val executor = ContextCompat.getMainExecutor(context)
        var isResultSubmitted = false // ← bandera

        val biometricPrompt = BiometricPrompt(
            activity,
            executor,
            object : BiometricPrompt.AuthenticationCallback() {
                override fun onAuthenticationSucceeded(resultAuth: BiometricPrompt.AuthenticationResult) {
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
                    // Solo mostramos que falló, pero esperamos que el usuario intente de nuevo o salga
                    println("Authentication failed. Please try again.")

                }
            }
        )

        val promptInfo = BiometricPrompt.PromptInfo.Builder()
            .setTitle("Autenticación Biométrica")
            .setSubtitle("Usa tu huella digital o rostro para iniciar sesión")
            .setNegativeButtonText("Cancelar")
            .build()

        biometricPrompt.authenticate(promptInfo)
    }
}
