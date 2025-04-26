# Android Nativo - Módulos QR Biometric App

Este proyecto Flutter integra dos módulos nativos en Android (Kotlin):

## 📸 Módulo de Escaneo QR

- **Tecnologías usadas:** CameraX + MLKit Barcode Scanning.
- **Pantalla nativa:** `QrScannerActivity` usando Jetpack Compose.
- **Funcionalidad:**
  - Permite escanear códigos QR de forma eficiente y rápida.
  - Optimizado para bajo consumo de recursos.
  - Comunicación con Flutter mediante **Pigeon** para retornar el resultado del escaneo.

**Ubicación:**  
`android/app/src/main/kotlin/com/example/qr_biometric_app/qrscan/`

---

## 🔒 Módulo de Autenticación Biométrica

- **Tecnologías usadas:** BiometricPrompt API.
- **Funcionalidad:**
  - Permite autenticación biométrica (huella o rostro).
  - Detecta si el dispositivo soporta biometría.
  - Si no está disponible o falla, Flutter maneja el fallback al PIN.
  - Integrado también mediante **Pigeon** para comunicación segura.

**Ubicación:**  
`android/app/src/main/kotlin/com/example/qr_biometric_app/biometric/`

---

## 📡 Comunicación Flutter ↔️ Android

- Se utiliza **Pigeon** como puente seguro de comunicación entre Dart ↔️ Kotlin.
- Definiciones automáticas de APIs para el escaneo y autenticación.

---

## 🛠️ Futuras Mejoras

- Mejorar detección de tipo de autenticación (huella vs rostro).
- Soporte a escaneo de QR en diferentes resoluciones y cámaras externas.

---

> **Nota:** El código nativo sigue buenas prácticas recomendadas por Google y es fácilmente extensible para nuevos módulos.
