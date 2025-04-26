# 🧪 Test Unitarios - QR Biometric App

Este proyecto incluye pruebas unitarias enfocadas en:

- **Autenticación y PIN** (`SecureStorageService`)
- **Escaneo y almacenamiento de QR** (`QrBloc` y casos de uso)

## 🔧 Tecnologías de Testing

- `flutter_test`
- `bloc_test`
- `mocktail`

## 🚀 Cómo ejecutar los tests

Desde la raíz del proyecto, simplemente corre:

```bash
flutter test
Esto ejecutará todas las pruebas disponibles en la carpeta test/.

📋 Cobertura actual
SecureStorageService: validación de almacenamiento seguro de PIN.

QrBloc: verificación de flujo de guardado y listado de QR codes.

Todos los tests han sido validados exitosamente (All tests passed ✅).